
# Marvelous News iOS

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
│                    Presentation Layer                       │
│              SwiftUI + TCA + Design System                 │
├─────────────────────────────────────────────────────────────┤
│                     Feature Layer                           │
│           FeatureArticleList + FeatureArticleDetails       │
├─────────────────────────────────────────────────────────────┤
│                      Domain Layer                           │
│              Use Cases + Repository Interfaces             │
├─────────────────────────────────────────────────────────────┤
│                      Data Layer                            │
│              Repositories + API Clients                    │
├─────────────────────────────────────────────────────────────┤
│                     Infrastructure Layer                    │
│              Networking + Configuration                     │
└─────────────────────────────────────────────────────────────┘
```

## 🛠 Technical Stack

### Core Technologies
- **Platform**: iOS 16.6+
- **Language**: Swift 6.0+
- **UI Framework**: SwiftUI
- **Architecture**: TCA (The Composable Architecture)
- **Concurrency**: Swift Concurrency (async/await)
- **Testing**: XCTest + ViewInspector

### Dependencies
- **[TCA](https://github.com/pointfreeco/swift-composable-architecture)**: State management and architecture
- **[Lottie](https://github.com/airbnb/lottie-ios)**: Rich animations
- **[ViewInspector](https://github.com/nalexn/ViewInspector)**: SwiftUI testing

### Development Tools
- **SwiftLint**: Code quality and consistency
- **Xcode 15.0+**: Latest development environment
- **Git**: Version control with conventional commits

## 📱 Features

### Core Functionality
- **News Article Display**: Tech news articles with rich content
- **Search & Filtering**: Real-time search with debouncing
- **Pagination**: Infinite scrolling (limited to 100 articles for performance)
- **Article Details**: Comprehensive article information display
- **Error Handling**: Graceful error states with retry mechanisms
- **Loading States**: Shimmer effects and Lottie animations

### Advanced Features
- **Accessibility**: VoiceOver support, Dynamic Type, semantic grouping
- **Performance**: Efficient list rendering, image loading, state management
- **Offline Resilience**: Graceful degradation when network unavailable
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
- Accessibility-first component design

#### **FeatureArticleList Module**
- Article list display and management
- Search functionality
- Pagination and infinite scrolling
- TCA state management

#### **FeatureArticleDetails Module**
- Article detail presentation
- Share functionality
- Browser integration

## 🔍 Code Quality & Standards

### SwiftLint Configuration
Each module has tailored SwiftLint rules:
- **Strict type safety** for CoreModels
- **Network-specific rules** for CoreNetworking
- **UI-focused rules** for DesignSystem
- **TCA-specific patterns** for Feature modules

### Code Standards
- **Naming Convention**: camelCase for functions and variables
- **Documentation**: Comprehensive inline documentation
- **Error Handling**: Structured error types with user-friendly messages
- **Concurrency**: Swift 6.0 concurrency safety with actors

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
xcodebuild test -scheme Marvelous-iOS

# Run specific module tests
xcodebuild test -scheme CoreModels
xcodebuild test -scheme CoreNetworking
xcodebuild test -scheme DesignSystem
xcodebuild test -scheme FeatureArticleList
xcodebuild test -scheme FeatureArticleDetails
```

### Test Coverage
- **Unit Tests**: Business logic, data models, networking
- **Integration Tests**: Feature workflows, API integration
- **UI Tests**: SwiftUI components, accessibility
- **Performance Tests**: List rendering, memory usage

## 🔧 Development Workflow

### Git Practices
- **Conventional Commits**: Structured commit messages
- **Feature Branches**: Isolated development work
- **Pull Request Reviews**: Code quality and architecture review
- **Semantic Versioning**: Clear version management

### Code Review Checklist
- [ ] Architecture principles followed
- [ ] TCA patterns implemented correctly
- [ ] Accessibility requirements met
- [ ] Test coverage adequate
- [ ] Performance considerations addressed
- [ ] Documentation updated

## 📚 Module Documentation

Each module contains comprehensive documentation:
- [Config](Marvelous-iOS/Config/README.md): Configuration management
- [CoreModels](Marvelous-iOS/CoreModels/README.md): Data models
- [CoreNetworking](Marvelous-iOS/CoreNetworking/README.md): Networking layer
- [DesignSystem](Marvelous-iOS/DesignSystem/README.md): UI components
- [FeatureArticleList](Marvelous-iOS/FeatureArticleList/README.md): Article list feature
- [FeatureArticleDetails](Marvelous-iOS/FeatureArticleDetails/README.md): Article details feature

## 🎯 Staff Engineer Considerations

### Architecture Decisions
- **Modular Design**: Enables team scalability and parallel development
- **Protocol-Oriented**: Swift-first approach with clear interfaces
- **TCA Implementation**: Demonstrates advanced state management knowledge
- **Clean Architecture**: Shows understanding of enterprise-level patterns

### Performance & Scalability
- **Efficient List Rendering**: Lazy loading and view recycling
- **Memory Management**: Proper use of value types and actors
- **Network Optimization**: Request batching and caching strategies
- **State Management**: Efficient TCA state updates and side effects

### Quality Assurance
- **Comprehensive Testing**: Unit, integration, and UI test coverage
- **Code Quality Tools**: SwiftLint integration and custom rules
- **Accessibility**: WCAG compliance and inclusive design
- **Error Handling**: Graceful degradation and user experience

## 🚀 Future Improvements

### Technical Enhancements
- **Offline Support**: Core Data integration and sync
- **Performance Monitoring**: Metrics collection and analysis
- **Advanced Caching**: Image and response caching strategies
- **Analytics**: User behavior tracking and insights

### Architecture Evolution
- **Multi-platform**: macOS and watchOS support
- **Modularization**: Further feature isolation
- **Dependency Injection**: Advanced DI container implementation
- **Plugin Architecture**: Extensible feature system

### Development Infrastructure
- **CI/CD Pipeline**: Automated testing and deployment
- **Code Generation**: Sourcery for boilerplate reduction
- **Documentation**: DocC integration and API documentation
- **Performance Testing**: Automated performance regression detection

## 👥 Contributing

### Development Guidelines
1. **Follow TCA patterns** for feature development
2. **Maintain test coverage** above 90%
3. **Ensure accessibility** compliance
4. **Document architectural decisions**
5. **Follow SwiftLint rules** for code consistency

### Pull Request Process
1. Create feature branch from `main`
2. Implement changes with comprehensive tests
3. Update documentation as needed
4. Ensure all tests pass
5. Submit PR with detailed description

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