# CoreModels Module

## Overview
The CoreModels module contains the core data models for the Marvel API integration in the Marvelous iOS app. It provides type-safe, `Sendable`-compliant models for Marvel characters and related data structures.

## Architecture

### 🏗 Structure
```
CoreModels/
├── Sources/
│   └── CoreModels/
│       ├── APIResponse.swift
│       ├── Hero.swift
│       └── Thumbnail.swift
└── Tests/
    └── CoreModelsTests/
        └── HeroDecodingTests.swift
```

### 📦 Key Components

#### 1. Core Models
- **Hero**: The main character model representing Marvel heroes
- **Thumbnail**: Image handling model with HTTPS URL conversion
- **APIResponse**: Generic wrapper for Marvel API responses

#### 2. Response Containers
```swift
public struct APIResponse<T: Decodable & Sendable>
public struct APIDataContainer<T: Decodable & Sendable>
```
- Generic response wrappers
- Support for pagination
- Type-safe data containers

#### 3. Related Models
- Comics, Series, Stories, and Events
- Each with their respective List and Summary types
- All conform to `Decodable` and `Sendable`

## Implementation Details

### Hero Model
```swift
public struct Hero: Decodable, Identifiable, Sendable {
    public let id: Int
    public let name: String
    public let description: String
    public let thumbnail: Thumbnail
    public let resourceURI: String
    public let comics: ComicList
    public let series: SeriesList
    public let stories: StoryList
    public let events: EventList
}
```

### Security & Performance
1. ✅ All types are `Sendable` for concurrent operations
2. ✅ Immutable properties prevent state inconsistencies
3. ✅ Efficient memory usage with value types
4. ✅ HTTPS enforcement in thumbnail URLs

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
