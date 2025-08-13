
# ~~Marvelous~~ News iOS

**IMPORTANT: This project began by using the Marvel API, but after four days of trying to get it to work, I decided to change the API, even though the name of the project may be misleading.**

A modern iOS application showcasing advanced iOS development practices, clean architecture, and comprehensive testing. Built for a Staff iOS Engineer technical test, this project demonstrates expertise in TCA (The Composable Architecture), Clean Architecture principles, accessibility, and modern Swift development.

## 🎯 Project Overview

**Technical Test Context**: This project was developed as a technical assessment for a Staff iOS Engineer position, demonstrating advanced iOS development skills, architectural decision-making, and best practices implementation.

**API Change Note**: Originally intended to use the Marvel API, the project was adapted to use the News API due to Marvel API availability issues. This demonstrates adaptability and problem-solving skills in real-world development scenarios.

## 🏗 Architecture & Design

### Core Architecture Principles
- **TCA (The Composable Architecture)**: State management, side effects, and unidirectional data flow
- **Clean Architecture**: Clear separation of concerns across layers
- **SOLID Principles**: Single responsibility, open/closed, Liskov substitution, interface segregation, dependency inversion
- **Modular Design**: Feature-based modules with clear boundaries
- **Protocol-Oriented Programming**: Swift-first approach with protocols and value types

### Architecture Layers
```
┌─────────────────────────────────────────────────────────────┐
│                      Presentation Layer                     │
│                 SwiftUI + TCA + Design System               │
├─────────────────────────────────────────────────────────────┤
│                        Feature Layer                        │
│           FeatureArticleList + FeatureArticleDetails        │
├─────────────────────────────────────────────────────────────┤
│                        Domain Layer                         │
│                Use Cases + Repository Interfaces            │
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
- **Platform**: iOS 16.6+
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
- **Git**: Version control with conventional commits

## 📱 Features

### Core Functionality
- **News Article Display**: Tech news articles with rich content
- **Search**: Real-time search with debouncing
- **Pagination**: Infinite scrolling (limited to 100 articles for performance)
- **Article Details**: Comprehensive article information display
- **Error Handling**: Graceful error states with retry mechanisms
- **Loading States**: Shimmer effects and Lottie animations

### Advanced Features
- **Accessibility**: VoiceOver support, Dynamic Type, semantic grouping
- **Performance**: Efficient list rendering, image loading, state management
- **Modern UI**: SwiftUI with custom design system components

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
└── Tests/                        # Comprehensive test suite
```

### Module Responsibilities

#### **Config Module**
- Environment configuration management
- API key handling with xcconfig files
- Secure secrets management

#### **CoreModels Module**
- Data models for news articles
- Sendable-compliant types for concurrency
- Codable implementations for API responses

#### **CoreNetworking Module**
- HTTP client with protocol-based design
- News API integration
- Error handling and status code validation

#### **DesignSystem Module**
- Reusable UI components
- Design tokens (colors, typography, spacing)
- Accessibility component design

#### **FeatureArticleList Module**
- Article list display
- Search functionality
- Pagination and infinite scrolling (Limited to 100 due API restrictions)
- TCA state management

#### **FeatureArticleDetails Module**
- Article detail presentation
- Share functionality
- Browser integration
- TCA state management

## 🔍 Code Quality & Standards

### SwiftLint Configuration
Each module has tailored SwiftLint rules:
- **Strict type safety** for the project and also Modules

### Code Standards
- **Naming Convention**: camelCase for functions and variables

### Testing Strategy
- **Unit Tests**: Business logic and data layer testing
- **Integration Tests**: Feature integration and API testing
- **UI Tests**: SwiftUI component testing with ViewInspector
- **Test Coverage**: Comprehensive coverage across all modules

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 16.6+
- Swift 6.0+
- SwiftLint (`brew install swiftlint`)

### Installation

1. **Clone the repository**:
```bash
git clone https://github.com/vcapilladeveloper/Marvelous.git
cd Marvelous
```

2. **Install development tools**:
```bash
brew install swiftlint
```

3. **Configure News API**:
   - Create `Config/Secrets.xcconfig`
   - Add your News API key:
```
NEWS_API_KEY=your_news_api_key_here
```

4. **Open and build**:
```bash
open Marvelous-iOS/Marvelous-iOS.xcodeproj
```

5. **Run tests**:
```bash
xcodebuild test -scheme Marvelous-iOS -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 🧪 Testing

### Test Execution
```bash
# Run all tests
xcodebuild test-without-building \
    -project Marvelous-iOS/Marvelous-iOS.xcodeproj \
    -scheme Marvelous-iOS \
    -destination 'platform=iOS Simulator,name=iPhone 16,OS=latest' \
    -skipMacroValidation
```

## 📚 Module Documentation

Each module contains comprehensive documentation:
- [Config](Marvelous-iOS/Config/README.md): Configuration management
- [CoreModels](Marvelous-iOS/CoreModels/README.md): Data models
- [CoreNetworking](Marvelous-iOS/CoreNetworking/README.md): Networking layer
- [DesignSystem](Marvelous-iOS/DesignSystem/README.md): UI components
- [FeatureArticleList](Marvelous-iOS/FeatureArticleList/README.md): Article list feature
- [FeatureArticleDetails](Marvelous-iOS/FeatureArticleDetails/README.md): Article details feature

# Future Improvements

I have written this section to highlight things that I have not had time to do and that I'm aware I should have done for the project. These suggestions focus on refining the development process, improving code quality, and expanding the testing suite.

---

## Code and Project Structure
* **Branching and Committing:** I'll adopt a more structured approach to branch management and commit history. This will involve using smaller, more focused branches and commits, making pull request reviews more straightforward and reducing the risk of introducing multiple changes at once.
* **Module Dependencies:** I've identified a dependency where `FeatureArticleList` relies on `FeatureArticleDetails`. I would refactor this to decouple the modules, improving the project's modularity and maintainability.
* **SwiftLint Configuration:** I've adjusted the **SwiftLint** configuration to only check code within specific modules, excluding third-party dependencies like **Lottie**. This prevents unnecessary linting errors and keeps the focus on project-specific code quality.

---

## Testing
* **UI Testing:** I'll expand the UI test coverage to include tests for the user experience (UX) flow. I also plan to move away from the **ViewInspector** library and implement a **snapshot testing** framework to ensure UI consistency.
* **Integration Testing:** I will implement **Pact tests** to create robust integration tests for the API. This will guarantee that our API contracts are consistent and prevent breaking changes with each release. Also define some Intergration test to ensure the integration between modules work as we spect.
* **Unit Testing:** I will focus on writing more effective unit tests and remove any that do not provide meaningful value.
* **Missing Tests:** I plan to add unit tests for the `FeatureArticleList` module to ensure its functionality is fully covered.

---

## CI/CD and Configuration
* **CI Configuration:** I would enhance the Continuous Integration (CI) configuration file to be more sophisticated. This would include setting up new runners for specific actions, such as creating release builds when merging to the `main` branch or deploying beta versions when merging to a `develop` branch.
* **Secrets Management:** I'll add a note to the Readme about the importance of the **Secrets.xcconfig** file. Without it, the `Config.Secrets` file won't work, which is a critical setup step.

---

## User Interface and Functionality
* **Article List Limitations:** I would remove the hardcoded limitation of only 100 articles and make the API call more dynamic. I would also add the ability to customize the default search parameters (`pageSize`, `language`, and `domain`).
* **Retry Button:** A retry button will be implemented for network requests that fail, improving the user experience during connectivity issues.
* **Data Loading:** I would explore alternative methods for loading data, such as loading models from a JSON file, to avoid potential security risks associated with public access control.

---

## Architectural Reflection
I chose to use **The Composable Architecture (TCA)** for this project. While I believe it’s a powerful architecture, I acknowledge that it might have been an over-engineering choice for a project of this scope, especially as it was my first time implementing it in a serious app.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

- [News API](https://newsapi.org/) for providing news data
- [TCA](https://github.com/pointfreeco/swift-composable-architecture) for architecture guidance
- [Lottie](https://github.com/airbnb/lottie-ios) for animation support
- [ViewInspector](https://github.com/nalexn/ViewInspector) for SwiftUI testing

## 📞 Contact

For questions about this technical test implementation:
- **Developer**: Victor Capilla Borrego
- **Position**: Staff iOS Engineer Candidate
- **Repository**: [GitHub](https://github.com/vcapilladeveloper/Marvelous)

---

**Note**: This project demonstrates advanced iOS development skills and architectural decision-making suitable for a Staff iOS Engineer position. The implementation showcases expertise in modern Swift development, TCA architecture, and comprehensive testing strategies.