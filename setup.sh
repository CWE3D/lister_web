#!/bin/bash

# Check if pyenv is installed
if ! command -v pyenv &> /dev/null
then
    echo "pyenv could not be found. Please install pyenv first."
    echo "Visit https://github.com/pyenv/pyenv#installation for installation instructions."
    exit 1
fi

# Set Python version
PYTHON_VERSION="3.9.16"

# Install Python version if not already installed
pyenv install $PYTHON_VERSION --skip-existing

# Create a new pyenv virtualenv
pyenv virtualenv $PYTHON_VERSION fastapi-project

# Set local Python version
pyenv local fastapi-project

# Upgrade pip
pip install --upgrade pip

# Install Python dependencies
pip install -r requirements.txt

# Install Tailwind CSS
npm install -D tailwindcss@3.3.0

# Initialize Tailwind CSS
npx tailwindcss init

# Create a basic FastAPI app
mkdir app
cat > app/main.py << EOL
from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
from fastapi.staticfiles import StaticFiles

app = FastAPI()

app.mount("/static", StaticFiles(directory="static"), name="static")
templates = Jinja2Templates(directory="templates")

@app.get("/")
async def root(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})
EOL

# Create templates directory and a basic HTML template
mkdir templates
cat > templates/index.html << EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FastAPI with Tailwind</title>
    <link href="{{ url_for('static', path='/css/main.css') }}" rel="stylesheet">
</head>
<body class="bg-gray-100">
    <div class="container mx-auto px-4 py-8">
        <h1 class="text-3xl font-bold text-blue-600">Welcome to FastAPI with Tailwind CSS!</h1>
        <p class="mt-4 text-gray-700">This is a basic template to get you started.</p>
    </div>
</body>
</html>
EOL

# Create static directory for CSS
mkdir -p static/css

# Create Tailwind CSS input file
cat > static/css/input.css << EOL
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Create Tailwind config
cat > tailwind.config.js << EOL
module.exports = {
  content: ["./templates/**/*.html"],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Add a build script to package.json
npm init -y
npm pkg set scripts.build="tailwindcss -i ./static/css/input.css -o ./static/css/main.css --minify"

echo "Setup complete. Run 'npm run build' to compile Tailwind CSS, then 'uvicorn app.main:app --reload' to start the FastAPI server."