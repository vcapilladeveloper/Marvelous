# FeatureArticleList Module

## Overview
The FeatureArticleList module implements the main news article list screen using The Composable Architecture (TCA). It provides a scalable and maintainable implementation for displaying, searching, and managing news article data, following Clean Architecture and SOLID principles.

## Architecture

### 🏗 Structure
```
FeatureArticleList/
├── Sources/
│   └── FeatureArticleList/
│       ├── Data/
│       │   ├── DataSource/
│       │   │   ├── ArticlesDataSource.swift
│       │   │   └── RemoteArticlesDataSource.swift
│       │   └── Repositories/
│       │       └── NewsArticlesRepository.swift
│       ├── Domain/
│       │   ├── Repositories/
│       │   │   └── ArticlesRepository.swift
│       │   └── UseCases/
│       │       └── FetchArticlesUseCase.swift
│       └── Presentation/
│           ├── Dependencies/
│           │   └── FetchArticlesUseCaseKey.swift
│           ├── ArticleListCoordinator.swift
│           ├── ArticleListFeature.swift
│           └── ArticleListView.swift
└── Tests/
    ├── DataSourceTests/
    │   └── RemoteArticlesDataSourceTests.swift
    ├── IntegrationTests/
    │   └── FeatureArticleListTests.swift
    └── RepositoriesTests/
        └── NewsArticlesRepositoryTests.swift
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
      public var selectedArticle: Identified<Article.ID, ArticleDetailsFeature.State?>?
      public var canLoadMore: Bool { items.count < min(total, 100) }
   }

   public enum Action {
      case onAppear
      case loadMore
      case searchQueryChanged(String)
      case retry
      case articlesResponse(Result<([Article], total: Int), Error>)
      case articleTapped(Article)
      case details(PresentationAction<ArticleDetailsFeature.Action>)
   }
   // ...reducer body...
}
```
- A TCA-based feature that manages the state and logic for the article list.
- Handles pagination (limited to 100 articles due to API constraints), search, and loading states.
- Manages navigation to the article details screen.

#### 2. View Layer
- SwiftUI views that are driven by the TCA `Store`.
- Composed of a main list view and reusable cell components.
- Integrates with the `DesignSystem` for a consistent look and feel.
- Navigation to the detail screen is handled via `sheet` or `navigationDestination`.

## Principles & Patterns
- **TCA**: The core of the feature, managing state, actions, and side effects.
- **SOLID**: The feature has a single responsibility: displaying and managing the list of articles.
- **Clean Architecture**: Clear separation between the presentation layer and business logic.
- **Error Handling**: Manages and displays error states gracefully.

## Implementation Details

### State Management
- The `State` struct holds all necessary data, including the list of articles, loading/error states, and search queries.
- State is mutated only by the reducer in response to actions.

### Dependency Injection
- The feature relies on an `ArticleListClient` (defined in the same file) to fetch articles. This client is injected into the reducer, allowing for easy mocking in tests.

## Dependencies
- The Composable Architecture
- `CoreModels` module
- `CoreNetworking` module
- `DesignSystem` module
- `FeatureArticleDetails` module
- SwiftUI

## Areas for Improvement

1. **Testing**: The module currently lacks unit and integration tests. Adding them is a high priority.
2. **Pagination**: The experience could be improved with caching and pre-fetching.
3. **Search**: Search could be enhanced with result caching and search history.
4. **Offline Support**: Implement local storage and a sync mechanism for offline access.

## Integration
The module is integrated as a local Swift Package and serves as the main entry point of the application.