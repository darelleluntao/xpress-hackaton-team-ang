# Tengu Project Architecture

## Project Overview

Tengu is a Flutter mono-repo project that uses Melos for package management. The project consists of multiple packages that work together to create a cohesive application ecosystem. The architecture follows clean architecture principles with a modular approach.

## Package Structure

The project is organized into the following main packages:

1. **core** - Shared functionality and base components used across all apps
2. **ned** - A Flutter application with its own UI and business logic
3. **gerry** - Another Flutter application with separate UI and business logic

### Core Package

The `core` package serves as the foundation for all other packages in the project. It provides:

- Network handling and API communication
- Authentication and user management
- Error handling and exceptions
- State management utilities
- Dependency injection
- Common UI components and theming
- Device information services

All applications in the project depend on this core package, which allows for code reuse and consistency across the apps.

#### Key Components in Core:

- **Error Handling**: `Failures` and `Exceptions` classes
- **Network**: `NetworkInfo`, `DioClient`, and API response models
- **Repositories**: Base repositories and implementations for data access
- **State Management**: Base state classes and providers
- **Theming**: Shared design tokens and theme configurations
- **Services**: Device information and other shared services

### App Packages (ned & gerry)

Both `ned` and `gerry` are standalone Flutter applications that share the same core functionality but have their own UI, navigation, and specific business logic.

#### Common Structure for App Packages:

- **Entry Points**: Multiple flavors (dev, staging, production)
- **Presentation**:
  - Screens (UI components)
  - Router (navigation configuration)
  - Widgets (reusable UI components)
- **Domain**: Business logic specific to the app
- **Data**: App-specific data handling

## Authentication Flow

Both applications implement a dual authentication approach:

1. **Email/Password Authentication**: Traditional login form with email and password
2. **Phone Authentication**: Login with phone number and OTP verification

Users can switch between these authentication methods with navigation buttons on the login screens.

### Authentication Routes:

- `/login` - Email/password login screen
- `/phone_login` - Phone number login screen
- `/otp` - OTP verification screen for phone login
- `/home` - Main app screen (authenticated)

## Navigation

The project uses `go_router` for navigation in both applications. The router configuration:

- Handles authentication state redirection
- Defines all app routes
- Manages deep linking
- Provides error handling for invalid routes

## State Management

The project uses Riverpod for state management with:

- `ConsumerWidget` and `ConsumerStatefulWidget` for UI components
- Provider pattern for accessing and modifying state
- Notifiers for managing complex state logic

## Theming and UI

Each app has its own theme based on shared design tokens from the core package:

- `ned` uses its own specific theme with branded colors
- `gerry` uses its own specific theme with different branded colors
- Both use Material 3 design system

## Data Flow

1. UI components interact with provider/notifiers
2. Notifiers call repositories
3. Repositories interact with data sources (API, local storage)
4. Data flows back through the same layers with appropriate transformations

## Environment Configuration

The project supports multiple environments through flavor configurations:

- Development
- Staging
- Production

Each environment can have different:

- API endpoints
- App names and IDs
- Configuration settings

## Package Dependencies

- **core**: Base package with no dependency on app packages
- **ned**: Depends on core
- **gerry**: Depends on core

This structure ensures that changes to the core package affect all apps, while changes to app packages remain isolated.

## Building and Running

The project uses Melos for managing the workspace. Common commands:

- `melos bootstrap`: Set up the project
- `melos run build`: Build all packages
- `melos run test`: Run tests across packages

To run a specific app with a flavor:

- `flutter run -t lib/main_dev.dart`
- `flutter run -t lib/main_staging.dart`
- `flutter run -t lib/main.dart` (production)
