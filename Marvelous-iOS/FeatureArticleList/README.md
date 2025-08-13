# FeatureArticleList Module

## Overview
The FeatureArticleList module implements the news article list feature using The Composable Architecture (TCA). It provides a scalable and maintainable implementation for displaying and managing news article data, following Clean Architecture and SOLID principles.

## Architecture

### 🏗 Structure
```
FeatureArticleList/
├── Sources/
│   └── FeatureHeroList/
│       ├── Data/
│       │   └── Repositories/
│       │       └── NewsArticlesRepository.swift
│       ├── Domain/
│       │   ├── Repositories/
│       │   │   └── ArticlesRepository.swift
│       │   └── UseCases/
│       │       └── FetchArticlesUseCase.swift
│       └── Presentation/
│           ├── ArticleListFeature.swift
│           ├── ArticleListView.swift
│           └── Dependencies/
│               └── FetchArticlesUseCaseKey.swift
└── Tests/
   └── FeatureArticleListTests/
      └── ArticleListIntegrationTests.swift
```

### 📦 Key Components

#### 1. Feature (TCA)
```swift
@Reducer
public struct ArticleListFeature {
   public struct State {
      public var items: [Article] = []
      public var isLoading = false
      public var errorMessage: String?
      public var searchQuery: String = ""
      public var page = 1
      public var total = 0
      public var selected: Article?
      public var canLoadMore: Bool { items.count < min(total, 100) }
   }
   
   public enum Action {
      case onAppear
      case loadMore
      case searchQueryChanged(String)
      case retry
      case articlesResponse(Result<([Article], total: Int), Error>)
      case didSelect(Article)
      case dismissDetail
   }
}
```
- TCA-based feature implementation
- Clean separation of state and actions
- Side effect management
- Pagination limited to 100 articles (`canLoadMore`)
- Search resets collection and reloads
- Retry clears state and reloads articles
- Navigation to detail via sheet using `selected` article

#### Example Usage
```swift
import FeatureArticleList
import ComposableArchitecture

let store = Store(initialState: ArticleListFeature.State()) {
   ArticleListFeature(fetch: myFetchClosure)
}
ArticleListView(store: store)
```

#### 2. View Layer
- SwiftUI views with TCA store integration
- Reusable components from DesignSystem
- Navigation to detail via sheet
- Accessibility support

#### 3. Domain Layer
- **ArticlesRepository**: Protocol for data access
- **FetchArticlesUseCase**: Business logic for fetching articles
- Clean separation of concerns

#### 4. Data Layer
- **NewsArticlesRepository**: Concrete implementation
- API integration via CoreNetworking
- Data transformation and caching

## Principles & Patterns
- **TCA**: Reducer, State, Action, Environment
- **SOLID**: Each feature and client has a single responsibility and can be extended
- **Clean Architecture**: Clear separation between presentation, domain, and data
- **Robust error handling** and retry logic

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme FeatureArticleList
```

## Good Practices
- Unit and integration tests
- Use of mocks for dependencies
- Documentation for features and clients
- Accessibility compliance

## Implementation Details

### State Management
- Proper state isolation
- Immutable data structures
- Clear state transitions
- Efficient state updates

### Actions
- Well-defined action types
- Side effect handling
- Error management
- Async operation support

### Testing
- Comprehensive unit tests
- Mock clients for testing
- Action testing
- State transition verification
- Integration testing

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

4. ✅ Accessibility
   - VoiceOver support
   - Dynamic Type
   - Semantic grouping

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

5. **Testing**
   - Increase test coverage
   - Add UI tests
   - Performance testing

## Feature Capabilities

### Article Display
- Grid layout for articles
- Image loading with fallbacks
- Article metadata display
- Responsive design

### Search Functionality
- Real-time search input
- Query debouncing
- Search result highlighting
- Empty state handling

### Pagination
- Load more on scroll
- Progress indicators
- Error handling for failed loads
- Maximum article limit (100)

### Error Handling
- Network error states
- Retry functionality
- User-friendly error messages
- Graceful degradation

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target and coordinates with FeatureArticleDetails for navigation.

## Performance Considerations

### List Optimization
- Lazy loading of views
- Efficient state updates
- Memory management
- Image caching

### State Management
- Minimal state updates
- Efficient side effects
- Proper dependency management
- Background task handling
