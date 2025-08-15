# FeatureArticleDetails Module

## Overview
The FeatureArticleDetails module displays detailed information about a selected news article in the Marvelous News iOS app. It uses The Composable Architecture (TCA), SOLID, and Clean Architecture principles for maintainability and testability.

## Architecture

### 🏗 Structure
```
FeatureArticleDetails/
├── Sources/
│   └── FeatureArticleDetails/
│       └── Presentation/
│           ├── ArticleDetailsFeature.swift
│           └── ArticleDetailsView.swift
└── Tests/
   └── FeatureArticleDetailsTests/
      └── ArticleDetailsReducerTests.swift
```

### 📦 Key Components

#### 1. Feature
```swift
public struct ArticleDetailsFeature: Reducer {
   public struct State: Equatable, Sendable {
      public let article: Article
      public var isShareSheetPresented = false
   }

   public enum Action: Equatable, Sendable {
      case onAppear
      case openInBrowserTapped
      case shareTapped
      case shareDismissed
   }

   public var body: some ReducerOf<Self> { /* ... */ }
}
```
- A TCA-based reducer that manages the state and logic for the article details screen.
- The `State` holds the selected article and properties for UI state, like presenting a share sheet.
- `Action` defines all possible user interactions and events.

#### 2. View Layer
- A SwiftUI view that is driven by a TCA `Store`.
- Displays the article's image, title, author, source, date, description, and content.
- Provides buttons for user actions like "Open in Browser" and "Share".

## Principles & Patterns
- **TCA**: The core of the feature, managing state, actions, and side effects.
- **SOLID**: The feature has a single responsibility: displaying the details of an article.
- **Clean Architecture**: Clear separation of concerns (the view is separate from the business logic).

## Accessibility
- All UI components include an `accessibilityLabel` and `accessibilityHint`.
- Colors and typography are designed to meet minimum contrast requirements.
- It is recommended to test with VoiceOver and Dynamic Type to ensure a good experience for all users.

## How to Use
- This feature is intended to be presented by another feature, like `FeatureArticleList`.
- To use it, you initialize its `Store` with the selected `Article`:
```swift
import FeatureArticleDetails
import ComposableArchitecture

let store = Store(initialState: ArticleDetailsFeature.State(article: selectedArticle)) {
   ArticleDetailsFeature()
}
ArticleDetailsView(store: store)
```

## Feature Capabilities

### Article Display
- **Header**: Displays the article's main image and title.
- **Content**: Shows the full description and content of the article.
- **Metadata**: Clearly presents the author, source, and publication date.

### User Interactions
- **Open in Browser**: Allows the user to open the original article URL in their default browser.
- **Share**: Presents the native iOS share sheet to share the article URL.

## Testing Strategy

### Unit Tests
- The reducer logic is tested in `ArticleDetailsReducerTests.swift`.
- Tests cover state changes in response to actions and ensure logic is correct.

## Areas for Improvement

1. **Content Enhancement**: Add related articles or a "read more" section.
2. **Performance**: For very long articles, content could be loaded lazily.
3. **Accessibility**: Add custom accessibility actions for power users (e.g., an action to read the author's name).

## Dependencies
- The Composable Architecture
- `CoreModels` module
- `DesignSystem` module
- SwiftUI