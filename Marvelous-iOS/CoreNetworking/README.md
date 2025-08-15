# CoreNetworking Module

## Overview
The CoreNetworking module provides a robust networking layer for the Marvelous News iOS app, handling all communication with the News API. It's designed with a protocol-oriented approach, following Clean Architecture and SOLID principles to ensure testability and maintainability.

## Architecture

### 🏗 Structure
```
CoreNetworking/
├── Sources/
│   └── CoreNetworking/
│       ├── APIClient.swift
│       ├── NewsAPI.swift
│       ├── NetworkError.swift
│       └── Helpers/
│           └── URLSessionProtocol.swift
└── Tests/
    └── CoreNetworkingTests/
        ├── APIClientTests.swift
        └── Helpers/
            └── URLSessionMock.swift
```

### 📦 Key Components

#### 1. APIClient
```swift
public protocol APIRequestable: Sendable {
    func fetch<T: Decodable & Sendable>(_ type: T.Type, from request: URLRequest) async throws -> T
}
```
- A protocol-based, generic API client responsible for making network requests.
- Uses async/await for modern, concurrent operations.
- Decouples the networking logic, allowing for easy mocking in tests.

#### 2. NewsAPI
- A concrete implementation that uses the `APIClient` to interact specifically with the News API.
- Constructs requests, adds the necessary API key authentication, and defines the available endpoints.

#### 3. NetworkError
```swift
public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)
}
```
- Provides specific, user-friendly error types for different networking failures.

## Implementation Details

### Best Practices
1. ✅ **Protocol-Oriented Design**: The use of `APIRequestable` and `URLSessionProtocol` allows for complete test coverage without making actual network calls.
2. ✅ **Modern Concurrency**: Leverages `async/await` for clean and efficient asynchronous code.
3. ✅ **Dependency Injection**: Dependencies are injected, making the components flexible and testable.
4. ✅ **Comprehensive Error Handling**: Provides clear, distinct error cases for better debugging and user feedback.

## Testing
The module includes comprehensive unit tests that cover:
- Successful API client decoding.
- Handling of various network errors (e.g., invalid status codes, decoding failures).
- Correct URL and request construction.
- All tests are performed against a mock URL session (`URLSessionMock`).

## Usage Example

```swift
import CoreNetworking
import CoreModels

// The APIClient is typically injected into a repository or use case.
let apiClient: APIRequestable = APIClient()

// Create an instance of the NewsAPI client
let newsAPI = NewsAPI(apiClient: apiClient, secretsProvider: yourSecretsProvider)

// Fetch top headlines
do {
    let response = try await newsAPI.getTopHeadlines(country: "us", page: 1)
    let articles = response.articles
    // Use the articles...
} catch {
    // Handle network errors
    print(error.localizedDescription)
}
```

## Areas for Improvement
1. **Response Caching**: Implement a caching mechanism (e.g., `URLCache`) to reduce redundant network calls and improve performance.
2. **Retry Logic**: Add a retry mechanism for transient network failures.
3. **Request Queueing**: For more complex scenarios, a request queue could be added to manage request priority and concurrency.
4. **Certificate Pinning**: For enhanced security, SSL certificate pinning could be implemented.

## Dependencies
- `CoreModels` module
- Requires iOS 16.0+
- Swift 6.0+

## Configuration

### API Key Setup
The News API requires an API key, which is provided by the `Config` module and added as an `X-Api-Key` header to requests.

### Base URL
The module uses the News API v2 base URL: `https://newsapi.org/v2`