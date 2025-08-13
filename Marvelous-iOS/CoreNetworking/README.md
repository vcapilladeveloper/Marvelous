# CoreNetworking Module

## Overview
The CoreNetworking module provides a robust networking layer for the Marvelous News iOS app, handling News API communication. It follows Clean Architecture and SOLID, with protocol-oriented design, error handling, and testability.

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
│           ├── String+MD5.swift
│           └── URLSessionProtocol.swift
└── Tests/
    └── CoreNetworkingTests/
        ├── APIClientTests.swift
        └── Helpers/
            └── URLSessionMock.swift
```

### 📦 Key Components


#### 1. API Client
```swift
public protocol APIRequestable: Sendable {
    func fetch<T: Decodable & Sendable>(_ type: T.Type, from request: URLRequest) async throws -> T
}
```
- Protocol-based design for testability
- Generic type support (Decodable & Sendable)
- Uses URLRequest for flexibility
- Async/await implementation
- Error handling

#### Example Usage
```swift
import CoreNetworking

let client: APIRequestable = APIClient()
var request = URLRequest(url: URL(string: "https://newsapi.org/v2/top-headlines")!)
request.setValue("YOUR_API_KEY", forHTTPHeaderField: "X-Api-Key")
let response = try await client.fetch(NewsAPIResponse.self, from: request)
```


#### 2. News API Client
- Handles News API authentication (API key)
- Manages API endpoints for articles, sources, etc.

#### 3. Error Handling
```swift
public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError(Error)
    case unknown(Error)
}
```

## Implementation Details

### Security Features
1. ✅ Secure hash generation for Marvel API
2. ✅ HTTPS enforcement
3. ✅ Proper error handling
4. ✅ Status code validation

### Networking Best Practices
1. ✅ Protocol-oriented design
2. ✅ Modern async/await API
3. ✅ Proper dependency injection
4. ✅ Comprehensive error handling
5. ✅ Unit test coverage with mocks

### Marvel API Integration
- Timestamp-based authentication
- MD5 hash generation
- Query parameter handling
- Pagination support

## Testing

The module includes comprehensive tests:
- API client functionality
- Marvel API authentication
- Error scenarios
- Mock URL session implementation

## Usage Example

```swift
// Initialize the API client
let apiClient = APIClient()
let marvelAPI = MarvelAPI(
    publicKey: publicKey,
    privateKey: privateKey,
    apiClient: apiClient
)

// Fetch characters
do {
    let response = try await marvelAPI.getCharacters(limit: 20, offset: 0)
    let heroes = response.data.results
} catch {
    print(error.localizedDescription)
}
```

## Areas for Improvement

1. **Caching**: Implement response caching
2. **Retry Logic**: Add retry mechanism for failed requests
3. **Rate Limiting**: Implement API rate limiting
4. **Request Queueing**: Add request queue management
5. **Metrics**: Add networking metrics collection
6. **Logging**: Enhanced network logging system
7. **Certificate Pinning**: Add SSL certificate pinning

## Dependencies
- CoreModels module
- Requires iOS 15.0+
- Swift 6.0+

## Advanced Features to Consider

### Request Pipeline
1. Request preparation
2. Authentication
3. Execution
4. Response processing
5. Error handling

### Middleware Support
- Request modification
- Response transformation
- Logging
- Analytics

## Configuration

### API Key Setup
The News API requires an API key to be set in the HTTP headers (See Config module documentation):
```swift
request.setValue(apiKey, forHTTPHeaderField: "X-Api-Key")
```

### Base URL
The module uses the News API v2 base URL:
```
https://newsapi.org/v2
```

## Error Handling

### Network Errors
- **Invalid URL**: Malformed request URLs
- **Request Failed**: HTTP status code errors
- **Decoding Error**: JSON parsing failures
- **Unknown Error**: Unexpected errors

### Status Code Handling
The module validates HTTP status codes and throws appropriate errors for non-success responses.

## Integration
The module is integrated as a local Swift Package and depends on the CoreModels module for data structures.
