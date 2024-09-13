# FastAPI with Tailwind CSS and Jinja2 Setup Guide

This guide explains how to set up and run a FastAPI project with Tailwind CSS and Jinja2, using pyenv for Python version management.

## Prerequisites

- [pyenv](https://github.com/pyenv/pyenv#installation) installed on your system
- [Node.js and npm](https://nodejs.org/) installed for Tailwind CSS

## Setup

1. Save the setup script as `setup.sh` and make it executable:

   ```bash
   chmod +x setup.sh
   ```

2. Create a `requirements.txt` file with the following content:

   ```
   fastapi==0.95.0
   uvicorn==0.21.1
   jinja2==3.1.2
   ```

3. Run the setup script:

   ```bash
   ./setup.sh
   ```

   This script will:
   - Use pyenv to install Python 3.9.16 (if not already installed)
   - Create a new pyenv virtualenv named `fastapi-project`
   - Install the Python dependencies from `requirements.txt`
   - Set up Tailwind CSS
   - Create a basic FastAPI application structure

## Running the Application

After running the setup script:

1. The pyenv environment will be automatically activated when you cd into the project directory.

2. Build the Tailwind CSS:

   ```bash
   npm run build
   ```

3. Start the FastAPI server:

   ```bash
   uvicorn app.main:app --reload
   ```

   The `--reload` flag enables auto-reloading when you make changes to your code.

4. Open your browser and navigate to `http://localhost:8000` to see your application running.

## Project Structure

The setup script creates the following structure:

```
your-project/
├── app/
│   └── main.py
├── static/
│   └── css/
│       ├── input.css
│       └── main.css (generated)
├── templates/
│   └── index.html
├── .python-version
├── requirements.txt
├── tailwind.config.js
└── package.json
```

- `app/main.py`: The main FastAPI application
- `static/css/input.css`: Tailwind CSS input file
- `static/css/main.css`: Generated Tailwind CSS output (after building)
- `templates/index.html`: A sample HTML template using Jinja2 and Tailwind CSS
- `.python-version`: Specifies the Python version for pyenv
- `tailwind.config.js`: Tailwind CSS configuration
- `package.json`: Node.js package file with scripts for building Tailwind CSS

## Next Steps

- Modify `app/main.py` to add your API endpoints
- Create new HTML templates in the `templates/` directory
- Customize your styles by modifying `static/css/input.css` and rebuilding Tailwind CSS

Remember to rebuild Tailwind CSS (`npm run build`) when you make changes to your CSS or templates, and restart the Uvicorn server if you make changes to your Python code (unless you're using the `--reload` flag).

Happy coding!