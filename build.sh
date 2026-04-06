#!/bin/bash

# Exit on error
set -e

# Clone Flutter only if it's not present
if [ ! -d "flutter" ]; then
    echo "Cloning Flutter..."
    git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

# Add Flutter to path
export PATH="$PATH:`pwd`/flutter/bin"

# Pre-download dependencies
flutter doctor
flutter precache --web

# Get packages
flutter pub get

# Ensure .env exists so flutter build doesn't fail (due to pubspec.yaml asset requirement)
touch .env

# Build web - API_KEY will be injected from Vercel's Environment Variables
echo "Building Flutter Web..."
flutter build web --release --dart-define=API_KEY=$API_KEY

echo "Build complete!"
