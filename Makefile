.PHONY: install test run clean docker-build docker-run docker-test help

# Installation des dépendances
init:
	python3 -m venv venv
	venv/bin/pip install -r requirements.txt
install:
	pip install -r requirements.txt

# Exécution des tests
test:
	python3 -m pytest test.py -v

# Exécution de l'application
run:
	python3 app.py

# Nettoyage des fichiers compilés Python
clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete

# Construction de l'image Docker
docker-build:
	docker build -t calculator:latest .

# Exécution de l'image Docker
docker-run:
	docker run -p 5000:5000 calculator:latest

# Exécution des tests dans Docker
docker-test:
	docker run calculator:latest python -m pytest test.py -v

# Aide pour les commandes disponibles
help:
	@echo "Available commands:"
	@echo "  make help         Display this help message"
	@echo "  make install      Install dependencies from requirements.txt"
	@echo "  make run          Run the application locally"
	@echo "  make test         Run unit tests"
	@echo "  make clean        Remove temporary and compiled files"
	@echo "  make docker-build Build the Docker image for the app"
	@echo "  make docker-run   Run the app in a Docker container"
	@echo "  make docker-test  Run tests inside a Docker container"
