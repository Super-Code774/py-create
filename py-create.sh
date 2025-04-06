#!/bin/bash
# Script de configuration de projet Python

# Log message
log_message() {
    echo "[INFO] $1"
}

# Handle errors
handle_error() {
    echo "[ERROR] $1"
    exit 1
}

# Nom du projet
read -p "Nom du projet : " project_name
if [ -z "$project_name" ]; then
    handle_error "Nom requis."
fi

# Créer le dossier du projet
mkdir -p $project_name || handle_error "Erreur création dossier."
log_message "Dossier '$project_name' créé."

# Structure des dossiers
mkdir -p $project_name/{src,tests,docs,data,configs,logs} || handle_error "Erreur structure."
log_message "Structure créée."

# Environnement virtuel
venv_dir="${project_name}_venv"
python3 -m venv $venv_dir || handle_error "Erreur venv."
log_message "Venv créé dans '$venv_dir'."

# Fichier requirements.txt
cat > $project_name/requirements.txt <<EOL
flask
requests
pandas
black
flake8
mypy
pytest
python-dotenv
SQLAlchemy
EOL
log_message "requirements.txt créé."

# Fichier .gitignore
cat > $project_name/.gitignore <<EOL
__pycache__/
*.py[cod]
*.env
*.venv
$venv_dir/
logs/
.vscode/
.idea/
EOL
log_message ".gitignore créé."

# README.md
cat > $project_name/README.md <<EOL
# $project_name
Description du projet.
EOL
log_message "README.md créé."

# LICENSE
cat > $project_name/LICENSE <<EOL
MIT License
EOL
log_message "LICENSE créé."

# main.py
cat > $project_name/src/main.py <<EOL
# main.py
import logging

def main():
    logging.basicConfig(level=logging.INFO)
    logging.info("Hello, World!")

if __name__ == "__main__":
    main()
EOL
log_message "main.py créé."

# Test pytest
cat > $project_name/tests/test_main.py <<EOL
def test_example():
    assert 1 + 1 == 2
EOL
log_message "Test pytest créé."

# Dockerfile
cat > $project_name/Dockerfile <<EOL
FROM python:3.9-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "src/main.py"]
EOL
log_message "Dockerfile créé."

# docker-compose.yml
cat > $project_name/docker-compose.yml <<EOL
version: '3.8'
services:
  app:
    build: .
    ports:
      - "5000:5000"
EOL
log_message "docker-compose.yml créé."

# .env
cat > $project_name/.env <<EOL
DEBUG=True
DATABASE_URL=sqlite:///data/db.sqlite3
EOL
log_message ".env créé."

# Initialisation Git
git init $project_name || handle_error "Erreur Git."
log_message "Repo Git initialisé."

# Pre-commit hooks
cat > $project_name/.pre-commit-config.yaml <<EOL
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.3.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
  - repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
      - id: black
EOL
log_message "Pre-commit configuré."

# Installer dépendances
source $venv_dir/bin/activate
pip install -r $project_name/requirements.txt || handle_error "Erreur installation deps."
log_message "Dépendances installées."

# Fin
log_message "Configuration terminée. Accédez à '$project_name' pour commencer."
