#!/bin/bash
# This script is made for creating Python projects easily

# Prompt the user for the project name
read -p "Enter the project name: " project_name
mkdir $project_name
cd $project_name

# Prompt the user to create a virtual environment
read -p "Do you want to create a virtual environment? (y/n): " create_venv
if [ "$create_venv" = "y" ]; then
    # Create the virtual environment
    python3 -m venv $project_name/venv
    echo "Virtual environment created."
fi

# Prompt the user to create a requirements.txt file
read -p "Do you want to create a requirements.txt file? (y/n): " create_requirements
if [ "$create_requirements" = "y" ]; then
    touch $project_name/requirements.txt
    echo "requirements.txt file created."
fi

# Prompt the user to create a .gitignore file
read -p "Do you want to create a .gitignore file? (y/n): " create_gitignore
if [ "$create_gitignore" = "y" ]; then
    touch $project_name/.gitignore
    echo ".gitignore file created."
fi

# Prompt the user to create a README.md file
read -p "Do you want to create a README.md file? (y/n): " create_readme
if [ "$create_readme" = "y" ]; then
    touch $project_name/README.md
    echo "README.md file created."
fi

# Prompt the user to install basic dependencies
read -p "Do you want to install basic dependencies? (y/n): " install_basics
if [ "$install_basics" = "y" ]; then
    # Install dependencies based on the operating system
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        pip3 install flask requests pandas PyQt5 thinker
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        pip3 install flask requests pandas PyQt5 thinker
    elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" || "$OSTYPE" == "win32" ]]; then
        pip3 install flask requests pandas PyQt5 thinker
    fi
fi

# Prompt the user to install additional dependencies
read -p "Do you want to install other dependencies? (y/n): " install_additional
if [ "$install_additional" = "y" ]; then
    # Prompt the user for the additional dependencies
    read -p "Enter the additional dependencies (separated by spaces): " additional_dependencies
    # Install the additional dependencies
    pip3 install $additional_dependencies
fi

read -p "Do you want to create a main.py file? (y/n): " create_main
if [ "$create_main" = "y" ]; then
    # Create the main.py file
    touch $project_name/main.py
    echo "main.py file created."
fi

# touch $project_name/main.py
#echo "main.py file created."


echo "Project setup complete."

