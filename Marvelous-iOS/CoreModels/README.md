# CoreModels Module

## Overview
The CoreModels module contains the core data models for the Marvelous News iOS app. It provides type-safe, `Sendable`-compliant models for news articles and related data structures, following SOLID and Clean Architecture principles.

## Architecture


### 🏗 Structure
```
CoreModels/
├── Sources/
│   └── CoreModels/
│       ├── NewsAPIResponse.swift
│       ├── Article.swift
│       └── Thumbnail.swift
└── Tests/
    └── CoreModelsTests/
        └── ArticleDecodingTests.swift
```

### 📦 Key Components

#### 1. Core Models
- **Article**: The main model representing a news article
- **Thumbnail**: Image handling model with HTTPS URL conversion
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
public struct NewsAPIResponse<T: Decodable & Sendable>
public struct NewsAPIDataContainer<T: Decodable & Sendable>
```
- Generic response wrappers
- Support for pagination
- Type-safe data containers


#### 3. Related Models
- Source, Author, and other metadata
- All conform to `Decodable` and `Sendable`

## Principles & Patterns
- SOLID: Cada modelo tiene una única responsabilidad y se puede extender sin modificar el código existente.
- Clean Architecture: Los modelos no dependen de frameworks externos.

## Dependencies
No external dependencies.

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme CoreModels
```

## Good Practices
- All models are documented.
- No force unwraps in production code.
- All models conform to `Sendable` for concurrency safety.

## Implementation Details

### Article Model
```swift
public struct Article: Decodable, Identifiable, Sendable, Equatable {
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
    public let publishedAt: Date?
    public let content: String?
}
```

### Security & Performance
1. ✅ All types are `Sendable` for concurrent operations
2. ✅ Immutable properties prevent state inconsistencies
3. ✅ Efficient memory usage with value types
4. ✅ HTTPS enforcement in image URLs

### Best Practices
1. ✅ Clear model separation
2. ✅ Protocol conformance for SwiftUI integration
3. ✅ Comprehensive test coverage
4. ✅ Type-safe generic containers
5. ✅ URL safety handling

## Testing

The module includes detailed tests in `HeroDecodingTests.swift`:
- JSON decoding validation
- URL conversion testing
- Data structure integrity checks

## Usage Example

```swift
// Decode a Hero from JSON
let decoder = JSONDecoder()
let hero = try decoder.decode(APIResponse<Hero>.self, from: jsonData)

// Access hero properties
let heroName = hero.data.results.first?.name
let thumbnailURL = hero.data.results.first?.thumbnail.url
```

## Areas for Improvement

1. **Validation**: Add value validation for critical fields
2. **Codable**: Implement custom encoding if needed
3. **Documentation**: Add DocC documentation
4. **Equatable**: Add Equatable conformance to all types
5. **Property Wrappers**: Consider custom property wrappers for common transformations

## Dependencies
- No external dependencies
- Requires iOS 15.0+
- Swift 6.0+

## Integration
The module is integrated as a local Swift Package and used by both the main app and CoreNetworking module.
