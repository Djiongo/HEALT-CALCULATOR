# Flask App - DevOps Project Template

This repository serves as a template for a simple Flask-based DevOps project. The app provides basic calculator functionalities (addition and subtraction) and includes all necessary files for setting up a local environment, running tests, and deploying to a cloud service with best practices in DevOps.

## Project Structure

The repository is organized as follows:

```plaintext
HEALT-CALCULATOR/
├── app.py
├── health_utils.py
├── test.py
├── requirements.txt
├── Makefile
github/
│   └── workflows/
        |_azure-container-webapp.yml
├── templates/
│   └── home.html
├── .env
├── .gitignore
```

### File Descriptions

- **`app.py`**: The main application file for the Flask app. It sets up routes and connects them to functions in `utils.py` to provide API endpoints for app operations.

- **`health_utils.py`**: Contains utility functions for core operations like addition and subtraction. This file is designed to house the main logic for the app’s functionality.

- **`test.py`**: A unit test file that includes tests for the functions defined in `utils.py`. This file ensures that the core functionality behaves as expected.

- **`requirements.txt`**: Lists the Python dependencies needed to run the application. This file is used to install the necessary packages in the project environment.

- **`Makefile`**: A makefile to streamline project setup and operations. Includes commands for:
  - `make init`: Install project dependencies.
  - `make run`: Start the Flask app.
  - `make test`: Run all unit tests.

- **`templates/home.html`**: HTML template for the app's user interface. This file provides input fields and buttons for interacting with the calculator operations.

- **`.env`**: A configuration file for environment variables. It’s used to securely store sensitive information (like API keys, database credentials, or environment-specific settings). **Note**: This file should not be committed to version control for security reasons.

- **`.gitignore`**: Specifies files and directories that should be ignored by Git. It typically includes files such as `.env` and compiled Python files (`__pycache__`), as well as local environment and dependency caches.

## Prerequisites

Before starting, ensure you have the following installed on your machine:

Azure CLI

Docker

Git

Python (Recommended: v3.8+)

1. **Clone the Repository**:
   ```bash
    Clone the project repository
git clone https://github.com/your-repo/calculator.git
cd calculator
           ```

2. **Set Up the Environment**:
   - Create and activate a virtual environment (recommended for managing dependencies).
   - Install the dependencies:
     ```bash
     # Create a virtual environment
python -m venv venv

# Activate the virtual environment (Windows)
venv\Scripts\activate

# Activate the virtual environment (Mac/Linux)
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt
     ```

3. **Run the Application**:
   - Start the Flask app locally:
     ```bash
     make run
     ```
The application should be running on http://localhost:5000.


4. **Dockerize the Application**:
   - Execute unit tests to verify functionality:
     ```bash
     # Build the Docker image
docker build -t calculator:latest .

# Run the container
docker run -dp 5000:5000 calculator:latest
     ```

## Step 5: Push the Docker Image to Azure Container Registry (ACR)


```bash
     # - **Login to Azure**:
      az login 

# Create an Azure Container Registry (If not already created)
az acr create --resource-group myResourceGroup --name calculator25 --sku Basic
# Login to ACR:
    az acr login --name calculator25

#  Tag and Push the Image
# Tag the image for ACR
docker tag calculator:latest calculator25.azurecr.io/calculator:latest

# Push the image to ACR
docker push calculator25.azurecr.io/calculator:latest
 ```
  - Use the `.env` file to store any environment-specific configurations or sensitive information. Be sure to keep this file out of version control by listing it in `.gitignore`.

## Deploy the App to Azure Web App
Create an Azure Web App

   ```az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name calculator --deployment-container-image-name calculator25.azurecr.io/calculator:latest   ```

 Configure Azure Web App to Use ACR Image

   ```az webapp config container set --name calculator --resource-group myResourceGroup --docker-custom-image-name calculator25.azurecr.io/calculator:latest --docker-registry-server-url https://calculator25.azurecr.io   ```

 Restart the Web App
```az webapp restart --name calculator --resource-group myResourceGroup```


For deployment, configure CI/CD pipelines according to your preferred platform (e.g., GitHub Actions, Azure Pipelines). This template can be used with cloud deployment platforms like AWS, Azure, or Heroku for easy scalability.
  - Use `pipeline.yaml` as a template for a pipeline to build and deploy an application on Azure

## Verify the Deployment

Open a browser and go to:

``` https://calculator.azurewebsites.net ```

If everything is set up correctly, your app should be running on Azure!

## Automate Deployment with GitHub Actions

Add Secrets to GitHub Repository

Go to Settings → Secrets and Variables → Actions and add:

ACR_USERNAME → calculator25

ACR_PASSWORD → (Get it using az acr credential show --name calculator25 --query "passwords[0].value" -o tsv)

 GitHub Actions Workflow (.github/workflows/azure-container-webapp.yml)


## This guide ensures a smooth deployment process for your Calculator app on Azure 
