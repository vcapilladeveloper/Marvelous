# Config Module

## Overview
The Config module is responsible for managing secure configuration and secrets in the Marvelous News iOS app. It primarily handles the News API key and provides a clean interface for accessing these secrets throughout the application.

## Architecture

### 🏗 Structure
```
Config/
├── Sources/
│   └── Config/
│       ├── Secrets.swift
│       ├── SecretsProvider.swift
│       └── SecretsError.swift
└── Tests/
    └── ConfigTests/
        └── SecretsTests.swift
```

### 📦 Key Components

#### 1. SecretsProvider Protocol
```swift
public protocol SecretsProvider {
    var newsAPIKey: String { get }
}
```
- Defines the contract for accessing the News API key.
- Enables dependency injection and testability.
- Follows the Interface Segregation Principle.

#### 2. Secrets Implementation
- Implements the `SecretsProvider` protocol.
- Loads secrets from the app's Info.plist.
- Uses a type-safe `SecretsKeys` enum to prevent typos.
- Handles error cases gracefully if a key is missing.

#### 3. Error Handling
- A custom `SecretsError` enum with localized descriptions.
- Provides a specific error case for missing keys.

## Implementation Details

### Security Considerations
1. **Secrets are stored in xcconfig files** (which are gitignored).
2. **No hardcoded values** in the source code.
3. **Keys are loaded at runtime** from the Info.plist, which sources them from the xcconfig file.
4. **Environment-specific configuration** is supported through different xcconfig files (e.g., Debug.xcconfig, Release.xcconfig).

## Configuration Setup

To use this module correctly and securely, you must provide your API key in an `.xcconfig` file.

### 1. Create Secrets.xcconfig
Create a `Secrets.xcconfig` file inside the `Marvelous-iOS/Config/` directory:

```xcconfig
// Marvelous-iOS/Config/Secrets.xcconfig
NEWS_API_KEY = your_news_api_key_here
```

### 2. Add to .gitignore
Ensure this file is never committed to version control. The project's `.gitignore` is already configured to ignore `**/Config/Secrets.xcconfig`.

### 3. Reference in Info.plist
In your main app target's `Info.plist`, reference the key like this:
```xml
<key>NewsAPIKey</key>
<string>$(NEWS_API_KEY)</string>
```

### 4. Link the xcconfig file in Xcode
In your project settings, under the "Configurations" section, you must assign the `Secrets.xcconfig` file to your build configurations.

## Security Notes

⚠️ **Important**: Never commit API keys or other secrets to version control. The `Secrets.xcconfig` file is intentionally excluded from git to prevent accidental exposure of sensitive credentials.

For team development, you can create a `Secrets.xcconfig.example` file with placeholder values to guide other developers in setting up their local environment.

## Dependencies
- No external dependencies.
- Requires iOS 16.0+
- Swift 6.0+