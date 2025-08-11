
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
      └── ArticleDetailsFeatureTests.swift
```

### 📦 Key Components

#### 1. Feature
```swift
public struct ArticleDetailsFeature: Reducer {
   public struct State: Equatable, Sendable {
      public let article: Article
      public var isShareSheetPresented = false
      // ...existing code...
   }

   public enum Action: Equatable, Sendable {
      case onAppear
      case openInBrowserTapped
      case shareTapped
      case shareDismissed
      // ...existing code...
   }

   public var body: some ReducerOf<Self> { /* ... */ }
}
```
- TCA-based reducer for article details
- State includes selected article and share sheet presentation
- Actions for appearing, opening in browser, sharing, and dismissing share sheet

#### Example Usage
```swift
import FeatureArticleDetails
import ComposableArchitecture

let store = Store(initialState: ArticleDetailsFeature.State(article: article)) {
   ArticleDetailsFeature()
}
ArticleDetailsView(store: store)
```

#### 2. View Layer
- SwiftUI view with TCA store integration
- Displays article image, title, author, source, date, description, and content
- Action buttons for "Open in Browser" and "Share"
- Presents share sheet when requested

#### 3. UI Details
- Uses DesignSystem components (PrimaryButton, AsyncRemoteImage)
- Accessibility labels and hints for all elements
- Responsive layout and color contrast

## Principles & Patterns
- TCA: Reducer, State, Action, Environment
- SOLID: Single responsibility for each feature/component
- Clean Architecture: Separation of presentation, domain, and data

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme FeatureArticleDetails
```

## Good Practices
- Unit and integration tests
- Use of mocks for dependencies
- Documentation for features and components
- Accessibility labels and hints for all UI elements

## Accessibility
- All components include `accessibilityLabel` and `accessibilityHint`
- Colors and typography meet minimum contrast requirements
- Recommended to test with VoiceOver and Dynamic Type

## How to Use
- Integrate with ArticleListFeature for navigation
- Pass selected article to ArticleDetailsFeature.State

## Future Improvements
- Add support for related articles
- Expand sharing functionality
- Add more UI tests for coverage
