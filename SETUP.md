# Tengu Project Setup Guide

This guide will walk you through setting up the Tengu project from scratch, including all prerequisites and development environment setup.

## Prerequisites Installation

### 1. Install Flutter SDK

#### macOS

```bash
# Using Homebrew
brew install --cask flutter

# Or download directly from Flutter website
# 1. Download Flutter from https://flutter.dev/docs/get-started/install/macos
# 2. Extract the file in the desired location, e.g.:
cd ~/development
unzip ~/Downloads/flutter_macos_*.zip

# 3. Add Flutter to your path by adding this to ~/.zshrc or ~/.bashrc:
export PATH="$PATH:`pwd`/flutter/bin"
```

#### Windows

1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract the zip file in a desired location (e.g., `C:\src\flutter`)
3. Add Flutter to your path:
   - From Start, search for 'Environment Variables'
   - Under System Variables, select `Path`
   - Click 'New' and add the path to `flutter\bin`

#### Linux

```bash
# Using snap
sudo snap install flutter --classic

# Or manual installation
# 1. Download Flutter SDK
# 2. Extract it:
cd ~/development
tar xf ~/Downloads/flutter_linux_*.tar.xz

# 3. Add Flutter to your path by adding to ~/.bashrc:
export PATH="$PATH:`pwd`/flutter/bin"
```

### 2. Verify Flutter Installation

```bash
# Verify the installation
flutter doctor

# Fix any issues reported by flutter doctor
```

### 3. Install Dart SDK

Flutter comes with Dart SDK, but verify the installation:

```bash
dart --version
```

## Project Setup

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Tengu
```

### 2. Install Melos

```bash
# Install Melos globally
dart pub global activate melos

# Add Melos to your PATH if needed
# For bash/zsh, add to ~/.bashrc or ~/.zshrc:
export PATH="$PATH":"$HOME/.pub-cache/bin"
```

### 3. Project Bootstrap

```bash
# Get root dependencies
dart pub get

# Bootstrap all packages
melos bootstrap
```

## Running the Applications

### Running Ned App

```bash
# Navigate to Ned directory
cd packages/ned

# Run the app
flutter run

# Or using Melos
melos run ned:run
```

### Running Gerry App

```bash
# Navigate to Gerry directory
cd packages/gerry

# Run the app
flutter run

# Or using Melos
melos run gerry:run
```

## Development Setup

### IDE Setup

#### VS Code

1. Install the Flutter extension
2. Install the Dart extension
3. Reload VS Code
4. Open Command Palette (Cmd/Ctrl + Shift + P)
5. Run 'Flutter: New Project'

#### Android Studio / IntelliJ

1. Install the Flutter plugin
2. Install the Dart plugin
3. Restart IDE
4. Configure Flutter SDK path in preferences

### Running Tests

```bash
# Run tests for all packages
melos run test

# Run tests for a specific package
cd packages/<package-name>
flutter test
```

## Common Issues and Solutions

### Flutter Doctor Issues

- If `flutter doctor` shows missing dependencies, install them using:
  ```bash
  flutter doctor --android-licenses  # For Android SDK issues
  ```

### Melos Issues

- If Melos commands aren't recognized, ensure it's in your PATH
- If bootstrap fails, try:
  ```bash
  melos clean
  melos bootstrap
  ```

### Platform-Specific Setup

#### iOS Development (macOS only)

1. Install Xcode from the App Store
2. Install Xcode Command Line Tools:
   ```bash
   xcode-select --install
   ```
3. Accept licenses:
   ```bash
   sudo xcodebuild -license accept
   ```

#### Android Development

1. Install Android Studio
2. Install Android SDK through Android Studio
3. Create/Setup Android Emulator through AVD Manager

## Project Structure

```
tengu/
├── melos.yaml           # Melos configuration
├── pubspec.yaml         # Root package configuration
├── packages/
│   ├── core/           # Shared core functionality
│   ├── ned/            # Ned mobile application
│   └── gerry/          # Gerry mobile application
```

## Updating Dependencies

```bash
# Update all dependencies
melos run update

# Update specific package
cd packages/<package-name>
flutter pub upgrade
```

## Troubleshooting

If you encounter any issues:

1. Ensure all prerequisites are installed correctly
2. Run `flutter doctor -v` to check for issues
3. Try cleaning the project:
   ```bash
   melos clean
   flutter clean
   melos bootstrap
   ```
4. Check if your Flutter and Dart versions match the project requirements
5. Ensure all environment variables are set correctly

## Additional Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Melos Documentation](https://melos.invertase.dev)
- [Flutter Community](https://flutter.dev/community)
