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
    var newsApiKey: String { get }
}
```
- Defines the contract for accessing News API key
- Enables dependency injection and testability
- Follows Interface Segregation Principle

#### 2. Secrets Implementation
- Implements `SecretsProvider` protocol
- Loads secrets from the app's Info.plist
- Uses type-safe key management through `SecretsKeys` enum
- Handles error cases gracefully

#### 3. Error Handling
- Custom `SecretsError` enum with localized descriptions
- Specific error case for missing keys
- User-friendly error messages with emoji 🔑

## Implementation Details

### Security Considerations
1. **Secrets are stored in xcconfig files** (gitignored)
2. **No hardcoded values** in the source code
3. **Keys are loaded at runtime** from Info.plist
4. **Environment-specific configuration** support

### Error Handling Strategy
```swift
public enum SecretsError: LocalizedError {
    case missingKey(String)
    // Provides user-friendly error messages
}
```

### Best Practices
1. ✅ Protocol-based design
2. ✅ Clear separation of concerns
3. ✅ Comprehensive unit tests
4. ✅ Type-safe key management
5. ✅ Proper error handling

## Testing

The module includes comprehensive tests in `SecretsTests.swift`:
- Tests successful key loading
- Tests error handling for missing keys
- Uses fake test data for predictable results

## Usage Example

```swift
// Initialize secrets
do {
    let secrets = try Secrets()
    // Use the secrets
    let apiKey = secrets.newsApiKey
} catch {
    // Handle errors
    print(error.localizedDescription)
}
```

## Configuration Setup

### 1. Create Secrets.xcconfig
Create a `Secrets.xcconfig` file in the `Config/` directory:

```xcconfig
// Secrets.xcconfig
NEWS_API_KEY = your_news_api_key_here
```

### 2. Add to .gitignore
Ensure the xcconfig file is not committed:
```gitignore
# Configuration
Config/Secrets.xcconfig
```

### 3. Reference in Info.plist
The app's Info.plist should reference the xcconfig:
```xml
<key>NEWS_API_KEY</key>
<string>$(NEWS_API_KEY)</string>
```

## Areas for Improvement

1. **Caching**: Consider adding caching for frequently accessed values
2. **Validation**: Add validation for key formats
3. **Key Rotation**: Support for key rotation mechanism
4. **Encryption**: Optional encryption for stored values
5. **Configuration Profiles**: Support for different environments (dev, staging, prod)
6. **Multiple API Support**: Extend for additional API keys if needed

## Dependencies
- No external dependencies
- Requires iOS 16.6+
- Swift 6.0+

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target and used by the CoreNetworking module for API authentication.

## Security Notes

⚠️ **Important**: Never commit API keys to version control. The `Secrets.xcconfig` file is intentionally excluded from git to prevent accidental exposure of sensitive credentials.

For team development, provide a `Secrets.xcconfig.example` file with placeholder values to guide other developers in setting up their local environment.
