#!/bin/bash
echo "Cloning Flutter SDK (stable channel)..."
git clone https://github.com/flutter/flutter.git -b stable

echo "Adding Flutter to PATH..."
export PATH="$PATH:`pwd`/flutter/bin"

echo "Resolving dependencies..."
flutter pub get

echo "Building Flutter Web for Vercel..."
flutter build web --release
