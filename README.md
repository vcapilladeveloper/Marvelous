# ~~Marvelous~~ News iOS

**IMPORTANT: This project began by using the Marvel API, but after four days of trying to get it to work, I decided to change the API, even though the name of the project may be misleading.**

**API ISSUES: Not only the restriction of 100 max articles per user, also on search option, some duplicated elements into the same response.**

![API Duplicated on search](DocResources/APIDuplicatedResponseJSONelements.PNG) 

A modern iOS application showcasing advanced iOS development practices, clean architecture, and comprehensive testing. Built for a Staff iOS Engineer technical test, this project demonstrates expertise in TCA (The Composable Architecture), Clean Architecture principles, accessibility, and modern Swift development.

## 🎯 Project Overview

**Technical Test Context**: This project was developed as a technical assessment for a Staff iOS Engineer position, demonstrating advanced iOS development skills, architectural decision-making, and best practices implementation.

**API Change Note**: Originally intended to use the Marvel API, the project was adapted to use the News API due to Marvel API availability issues. This demonstrates adaptability and problem-solving skills in real-world development scenarios.

## 🏗 Architecture & Design

### Core Architecture Principles
- **TCA (The Composable Architecture)**: State management, side effects, and unidirectional data flow.
- **Clean Architecture**: Clear separation of concerns across layers.
- **SOLID Principles**: Single responsibility, open/closed, Liskov substitution, interface segregation, dependency inversion.
- **Modular Design**: Feature-based modules with clear boundaries.
- **Protocol-Oriented Programming**: A Swift-first approach using protocols and value types.

### Architecture Layers
```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                     │
│                 SwiftUI + TCA + Design System               │
├─────────────────────────────────────────────────────────────┤
│                        Feature Layer                        │
│           FeatureArticleList + FeatureArticleDetails        │
├─────────────────────────────────────────────────────────────┤
│                         Data Layer                          │
│                Repositories + API Clients                   │
├─────────────────────────────────────────────────────────────┤
│                     Infrastructure Layer                    │
│                 Networking + Configuration                  │
└─────────────────────────────────────────────────────────────┘
```

## 🛠 Technical Stack

### Core Technologies
- **Platform**: iOS 16.0+
- **Language**: Swift 6.0+
- **UI Framework**: SwiftUI
- **Architecture**: TCA (The Composable Architecture) + Clean Architecture
- **Concurrency**: Swift Concurrency (async/await)
- **Testing**: XCTest + ViewInspector

### Dependencies
- **[TCA](https://github.com/pointfreeco/swift-composable-architecture)**: State management and architecture
- **[Lottie](https://github.com/airbnb/lottie-ios)**: Rich animations
- **[ViewInspector](https://github.com/nalexn/ViewInspector)**: SwiftUI testing

### Development Tools
- **SwiftLint**: Code quality and consistency
- **Xcode 16.0+**: Latest development environment
- **Git**: Version control

## 📱 Features

### Core Functionality
- **News Article Display**: Tech news articles with rich content.
- **Search**: Real-time search with debouncing.
- **Pagination**: Infinite scrolling (limited to 100 articles for performance).
- **Article Details**: Comprehensive article information display.
- **Error Handling**: Graceful error states with retry mechanisms.
- **Loading States**: Shimmer effects and Lottie animations.

### Advanced Features
- **Accessibility**: VoiceOver support, Dynamic Type, and semantic grouping.
- **Performance**: Efficient list rendering, image loading, and state management.
- **Modern UI**: A custom design system built with SwiftUI.

## 🎬 Demo & Screenshots

| Feature                | Preview                                      |
|------------------------|----------------------------------------------|
| Article List (Light)   | ![Light Theme](DocResources/LightTheme.gif)  |
| Article Details        | ![Details Screen](DocResources/DetailsScreen.gif) |
| Search Functionality   | ![Search](DocResources/Search.gif)           |
| Loading State          | ![Loading](DocResources/LoadingVideo.gif)    |
| Shimmer Effect         | ![Shimmer](DocResources/Shimmer.gif)         |
| Error Handling         | ![Error](DocResources/Error.PNG)             |

## 🏛 Project Structure

```
Marvelous-iOS/
├── App/                          # Main iOS app target
├── Config/                       # Configuration and secrets management
├── CoreModels/                   # Core data models and types
├── CoreNetworking/               # Networking and API layer
├── DesignSystem/                 # UI components and design tokens
├── FeatureArticleList/           # Article list feature module
├── FeatureArticleDetails/        # Article details feature module
└── Tests/                        # Test suites for each module
```

## 🚀 Getting Started

### Prerequisites
- Xcode 16.0+
- Swift 6.0+
- iOS 16.0+
- SwiftLint (`brew install swiftlint`)

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/vcapilladeveloper/Marvelous.git
cd Marvelous
```

2. **Configure News API**:
   - Create a `Secrets.xcconfig` file in `Marvelous-iOS/Config/`.
   - Add your News API key to this file:
```
NEWS_API_KEY=your_news_api_key_here
```
   - **Note**: The project will not build without this file and key.

3. **Open and build**:
```bash
open Marvelous-iOS/Marvelous-iOS.xcodeproj
```

4. **Run tests**:
```bash
xcodebuild test -scheme Marvelous-iOS -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 🧪 Testing

Each module contains its own set of unit and/or UI tests. You can run all tests for the main scheme using the command above or run tests for individual packages directly in Xcode.

## 📚 Module Documentation

Each module contains its own comprehensive `README.md` file:
- [Config](Marvelous-iOS/Config/README.md)
- [CoreModels](Marvelous-iOS/CoreModels/README.md)
- [CoreNetworking](Marvelous-iOS/CoreNetworking/README.md)
- [DesignSystem](Marvelous-iOS/DesignSystem/README.md)
- [FeatureArticleList](Marvelous-iOS/FeatureArticleList/README.md)
- [FeatureArticleDetails](Marvelous-iOS/FeatureArticleDetails/README.md)

## Future Improvements

This section highlights things that I have not had time to do and that I'm aware I should have done for the project.

* **Branching and Committing:** Adopt a more structured approach to branch management and commit history (e.g., smaller, more focused commits).
* **Module Dependencies:** Refactor the dependency between `FeatureArticleList` and `FeatureArticleDetails` to improve modularity.
* **Testing:**
    *   Expand UI test coverage with snapshot tests.
    *   Implement integration tests (e.g., Pact tests) for the API contract.
    *   Add unit tests for the `FeatureArticleList` module.
* **CI/CD:** Enhance the CI configuration with more sophisticated workflows (e.g., release builds on merge to `main`).
* **Functionality:**
    *   Remove the hardcoded limit of 100 articles in the `FeatureArticleList`.
    *   Implement a "Retry" button for failed network requests.

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgements

- [News API](https://newsapi.org/) for providing news data.
- [The Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture) for the architectural framework.
- [Lottie](https://github.com/airbnb/lottie-ios) for animation support.
- [ViewInspector](https://github.com/nalexn/ViewInspector) for SwiftUI testing.