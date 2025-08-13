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
```

### 📦 Key Components


#### 1. Feature
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
   // ...existing code...
}
```
- TCA-based feature implementation
- Clean separation of state and actions
- Side effect management
- Pagination limited to 100 articles (`canLoadMore`)
- Search resets collection and reloads
- Retry clears state and reloads articles (Not implemented)
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

#### 1. View Layer
- SwiftUI views with TCA store integration
- Reusable components
- Design System integration
- Navigation to detail via sheet

#### 2. Domain Layer
- **ArticlesRepository**: Protocol for data access
- **FetchArticlesUseCase**: Business logic for fetching articles
- Clean separation of concerns

#### 3. Data Layer
- **NewsArticlesRepository**: Concrete implementation
- API integration via CoreNetworking
- Data transformation and caching

## Principles & Patterns
- **TCA**: Reducer, State, Action, Environment
- **SOLID**: Each feature and client has a single responsibility and can be extended
- **Clean Architecture**: Clear separation between presentation, domain, and data
- **Robust error handling** and retry logic (Not Implemented)

## Implementation Details

### State Management
- Proper state isolation
- Immutable data structures
- Clear state transitions

### Actions
- Well-defined action types
- Side effect handling
- Error management

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

## Areas for Improvement

1. **Pagination**
   - Cache management
   - Prefetching

2. **Search**
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
   - Add UI, Unit and Integration tests
   - Performance testing

## Feature Capabilities

### Article Display
- Grid layout for articles
- Image loading with fallbacks
- Article metadata display

### Search Functionality
- Real-time search input
- Query debouncing
- Search result highlighting

### Pagination
- Load more on scroll
- Progress indicators
- Error handling for failed loads
- Maximum article limit (100)

### Error Handling
- Network error states
- Retry functionality (Not implemented)
- User-friendly error messages

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target.
