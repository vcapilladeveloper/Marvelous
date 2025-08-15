# CoreModels Module

## Overview
The CoreModels module contains the core data models for the Marvelous News iOS app. It provides type-safe, `Sendable`-compliant models for news articles and related data structures.

## Architecture

### 🏗 Structure
```
CoreModels/
├── Sources/
│   └── CoreModels/
│       ├── NewsAPIResponse.swift
│       └── Article.swift
└── Tests/
    └── CoreModelsTests/
        └── ArticleDecodingTests.swift
```

### 📦 Key Components

#### 1. Core Models
- **Article**: The main model representing a news article.
- **Source**: A model for the article's source (e.g., BBC News).
- **NewsAPIResponse**: A generic wrapper for News API responses.

#### 2. Article Model
```swift
public struct Article: Codable, Identifiable, Sendable, Equatable {
    public var id: String { url ?? UUID().uuidString } // stable enough for UI lists
    public let source: Source?
    public let author: String?
    public let title: String?
    public let description: String?
    public let url: String?
    public let urlToImage: String?
    public let publishedAt: String?
    public let content: String?

    public var imageURL: URL? { URL(string: urlToImage ?? "") }
    public var webURL: URL? { URL(string: url ?? "") }
}
```

## Principles & Patterns
- **SOLID**: Each model has a single responsibility and can be extended without modifying existing code.
- **Clean Architecture**: The models do not depend on external frameworks.

## Implementation Details

### Security & Performance
1. ✅ All types are `Sendable` for safe use in concurrent operations.
2. ✅ Immutable properties (`let`) prevent inconsistent states.
3. ✅ Value types (`struct`) ensure efficient memory usage.

### Best Practices
1. ✅ Clear separation of models.
2. ✅ Conformance to standard protocols (`Codable`, `Identifiable`, `Equatable`) for easy integration.
3. ✅ Comprehensive test coverage for decoding.
4. ✅ URL safety handling with optional `URL` computed properties.

## Testing

The module includes detailed tests in `ArticleDecodingTests.swift` that validate:
- Correct JSON decoding of all models.
- Data structure integrity.
- Handling of optional or missing values.

## Usage Example

```swift
// Decode an Article from JSON
let decoder = JSONDecoder()
let response = try decoder.decode(NewsAPIResponse.self, from: jsonData)

// Access article properties
if let firstArticle = response.articles?.first {
    let articleTitle = firstArticle.title
    let imageURL = firstArticle.imageURL
}
```

## Areas for Improvement

1. **Date Formatting**: The `publishedAt` field is currently a `String`. This could be decoded into a `Date` object using a custom decoding strategy for easier manipulation.
2. **Validation**: Add value validation for critical fields (e.g., ensuring URLs are valid).
3. **Documentation**: Add DocC documentation for all public models and properties.

## Dependencies
- No external dependencies
- Requires iOS 16.0+
- Swift 6.0+

## Integration
The module is integrated as a local Swift Package and is a dependency for `CoreNetworking`, the Feature modules, and the main application.