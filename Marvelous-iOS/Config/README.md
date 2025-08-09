# Config Module

## Overview
The Config module is responsible for managing secure configuration and secrets in the Marvelous iOS app. It primarily handles the Marvel API keys and provides a clean interface for accessing these secrets throughout the application.

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
    var marvelPublicKey: String { get }
    var marvelPrivateKey: String { get }
}
```
- Defines the contract for accessing Marvel API keys
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
1. Secrets are stored in xcconfig files (gitignored)
2. No hardcoded values in the source code
3. Keys are loaded at runtime from Info.plist

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
    let publicKey = secrets.marvelPublicKey
    let privateKey = secrets.marvelPrivateKey
} catch {
    // Handle errors
    print(error.localizedDescription)
}
```

## Areas for Improvement

1. **Caching**: Consider adding caching for frequently accessed values
2. **Validation**: Add validation for key formats
3. **Key Rotation**: Support for key rotation mechanism
4. **Encryption**: Optional encryption for stored values
5. **Configuration Profiles**: Support for different environments (dev, staging, prod)

## Dependencies
- No external dependencies
- Requires iOS 15.0+
- Swift 6.0+

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target.
