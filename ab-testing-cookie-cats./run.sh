#!/usr/bin/env bash

set -e # Exit immediately if a command exits with a non-zero status.

ask_yes_no() {
    while true; do
        read -n 1 -p "$1 [y/n]: " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo $'Please answer yes or no.\n';;
        esac
    done
}

if ask_yes_no "Install dependencies from requirements.txt?"; then
    echo $'Installing dependencies...\n'
    pip install -r requirements.txt
else
    echo $'Skipping dependency installation.\n'
fi

if ask_yes_no "Download the dataset?"; then
    echo $'Downloading dataset...\n'

    curl -L \
        -o ./mobile-games-ab-testing.zip \
        "https://www.kaggle.com/api/v1/datasets/download/yufengsui/mobile-games-ab-testing"
    
    echo $'Unzipping dataset...\n'
    mkdir -p data
    unzip ./mobile-games-ab-testing.zip -d data/
    rm -f ./mobile-games-ab-testing.zip
else
    echo $'Skipping dataset download.\n'
fi

echo $'Running analysis...\n'
python3 run_analysis.py








