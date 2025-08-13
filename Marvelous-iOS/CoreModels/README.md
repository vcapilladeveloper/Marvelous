# CoreModels Module

## Overview
The CoreModels module contains the core data models for the Marvelous News iOS app. It provides type-safe, `Sendable`-compliant models for news articles and related data structures, following SOLID and Clean Architecture principles.

## Architecture

### 🏗 Structure
```
CoreModels/
├── Sources/
│   └── CoreModels/
│       └── NewsAPIResponse.swift
└── Tests/
    └── CoreModelsTests/
        └── ArticleDecodingTests.swift
```

### 📦 Key Components

#### 1. Core Models
- **Article**: The main model representing a news article
- **Source**: Information about the news source
- **NewsAPIResponse**: Generic wrapper for News API responses

#### Example Usage
```swift
import CoreModels

let article = Article(
    source: Source(id: "techcrunch", name: "TechCrunch"),
    author: "Jane Doe",
    title: "Breaking News",
    description: "Latest tech news...",
    url: "https://news.com/article",
    urlToImage: "https://news.com/image.jpg",
    publishedAt: "2025-08-11T12:00:00Z",
    content: "Full article content..."
)
print(article.title)
print(article.id) // Derived from url or UUID
print(article.imageURL) // Computed property for image URL
print(article.webURL)   // Computed property for web URL
```

#### 2. Response Containers
```swift
public struct NewsAPIResponse: Codable, Sendable, Equatable {
    public let status: String
    public let totalResults: Int?
    public let articles: [Article]?
}
```
- Generic response wrappers
- Support for pagination
- Type-safe data containers

#### 3. Related Models
- Source, Author, and other metadata
- All conform to `Codable`, `Sendable`, and `Equatable`

## Principles & Patterns
- **SOLID**: Each model has a single responsibility and can be extended without modifying existing code
- **Clean Architecture**: Models don't depend on external frameworks
- **Protocol-Oriented**: Swift-first approach with value types

## Dependencies
No external dependencies.

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme CoreModels
```

## Good Practices
- All models are documented
- No force unwraps in production code
- All models conform to `Sendable` for concurrency safety
- Comprehensive test coverage

## Implementation Details

### Article Model
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

### Source Model
```swift
public struct Source: Codable, Sendable, Equatable {
    public let id: String?
    public let name: String?
}
```

### Security & Performance
1. ✅ All types are `Sendable` for concurrent operations
2. ✅ Immutable properties prevent state inconsistencies
3. ✅ Efficient memory usage with value types
4. ✅ URL safety handling with computed properties

### Best Practices
1. ✅ Clear model separation
2. ✅ Protocol conformance for SwiftUI integration
3. ✅ Comprehensive test coverage
4. ✅ Type-safe containers
5. ✅ URL safety handling

## Testing

The module includes detailed tests in `ArticleDecodingTests.swift`:
- JSON decoding validation
- URL conversion testing
- Data structure integrity checks
- Mock data consistency verification

## Usage Example

```swift
// Decode a News API response from JSON
let decoder = JSONDecoder()
let response = try decoder.decode(NewsAPIResponse.self, from: jsonData)

// Access article properties
let articles = response.articles ?? []
let totalResults = response.totalResults ?? 0

// Use articles in SwiftUI
ForEach(articles) { article in
    ArticleCard(article: article)
}
```

## Mock Data

The module provides mock data for testing:
```swift
// Use mock article for testing
let mockArticle = Article.mock

// Use mock response for testing
let mockResponse = NewsAPIResponse.mock
```

## Areas for Improvement

1. **Validation**: Add value validation for critical fields
2. **Date Handling**: Convert `publishedAt` to proper `Date` type
3. **Documentation**: Add DocC documentation
4. **Property Wrappers**: Consider custom property wrappers for common transformations
5. **Coding Keys**: Add custom coding keys for API compatibility

## Dependencies
- No external dependencies
- Requires iOS 16.6+
- Swift 6.0+

## Integration
The module is integrated as a local Swift Package and used by both the main app and CoreNetworking module for data structures.
