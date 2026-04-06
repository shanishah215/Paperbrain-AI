#!/bin/bash

# Exit immediately if any command fails
set -e

# Increase memory for Flutter build if needed
export FLUTTER_MEMORY_LIMIT=2048

# Clone Flutter stable if not already present
if [ ! -d "flutter" ]; then
    echo "Cloning Flutter SDK..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Set Flutter path (using absolute path for safety)
export PATH="$PATH:$(pwd)/flutter/bin"

# Pre-download web artifacts
echo "Pre-caching web artifacts..."
flutter config --enable-web
flutter precache --web

# Get dependencies
echo "Fetching dependencies..."
flutter pub get

# Create dummy .env since it's referenced in pubspec.yaml
touch .env

# Final Build - Use --dart-define-from-file if you have many vars, 
# but for a single key, this is more direct.
echo "Building Flutter Web Client..."
flutter build web --release --dart-define=API_KEY=$API_KEY

echo "Deploy Ready Assets Generated!"
