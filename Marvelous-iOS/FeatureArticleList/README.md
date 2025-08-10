# FeatureArticleList Module

## Overview
The FeatureArticleList module implements the news article list feature using The Composable Architecture (TCA). It provides a scalable and maintainable implementation for displaying and managing news article data, siguiendo Clean Architecture y SOLID.

## Architecture


### 🏗 Structure
```
FeatureArticleList/
├── Sources/
│   └── FeatureArticleList/
│       ├── Feature/
│       │   ├── ArticleListFeature.swift
│       │   └── ArticleListView.swift
│       ├── Components/
│       │   └── ArticleListCell.swift
│       └── Client/
│           └── ArticleListClient.swift
└── Tests/
   └── FeatureArticleListTests/
      ├── ArticleListFeatureTests.swift
      └── Helpers/
         └── MockArticleListClient.swift
```

### 📦 Key Components

#### 1. Feature
```swift
@Reducer
public struct ArticleListFeature {
   public struct State { }
   public enum Action { }
   public var body: some ReducerOf<Self> { }
}
```
- TCA-based feature implementation
- Clean separation of state and actions
- Side effect management

#### Example Usage
```swift
import FeatureArticleList
import ComposableArchitecture

let store = Store(initialState: ArticleListFeature.State()) {
   ArticleListFeature()
}
ArticleListView(store: store)
```


#### 2. View Layer
- SwiftUI views with TCA store integration
- Reusable components
- Design System integration


#### 3. Client Layer
- Protocol-based API client for News
- Testable dependencies
- Clean data flow

## Principles & Patterns
- TCA: Reducer, State, Action, Environment.
- SOLID: Cada feature y cliente tiene una única responsabilidad y se puede extender.
- Clean Architecture: Separación clara entre presentación, dominio y datos.

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme FeatureHeroList
```

## Good Practices
- Tests unitarios y de integración.
- Uso de mocks para dependencias.
- Documentación en los features y clientes.

## Implementation Details

### State Management
- Proper state isolation
- Immutable data structures
- Clear state transitions

### Actions
- Well-defined action types
- Side effect handling
- Error management

### Testing
- Comprehensive unit tests
- Mock clients for testing
- Action testing
- State transition verification

## Best Practices

1. ✅ TCA Guidelines
   - Pure reducers
   - Controlled side effects
   - Dependency injection

2. ✅ SwiftUI Integration
   - Store management
   - View composition
   - Performance optimization

3. ✅ Error Handling
   - User-friendly errors
   - Retry mechanisms
   - Loading states

## Dependencies
- The Composable Architecture
- CoreModels module
- CoreNetworking module
- DesignSystem module
- SwiftUI
- Combine

## SwiftLint Configuration
Custom rules for TCA-based code:
- Reducer action ordering
- State mutation patterns
- Effect handling

## Areas for Improvement

1. **Pagination**
   - Implement infinite scrolling
   - Cache management
   - Prefetching

2. **Search**
   - Real-time search
   - Search result caching
   - Search history

3. **Offline Support**
   - Local storage
   - Sync mechanism
   - Conflict resolution

4. **Performance**
   - List optimization
   - Image caching
   - State updates

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target.
