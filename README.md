# Marvelous iOS

A modern iOS application for Marvel lovers, showcasing clean architecture, modular design, and best practices in iOS development.

## 🏗 Project Structure

```
Marvelous-iOS/
├── App/                  # Main iOS app target
├── Config/              # Configuration and secrets management
├── CoreModels/          # Core data models and types
├── CoreNetworking/      # Networking and API layer
├── DesignSystem/        # UI components and styles
└── FeatureHeroList/     # Character list feature module
```

## 🛠 Technical Stack

- **Platform**: iOS 15+
- **Language**: Swift 6.0+
- **UI Framework**: SwiftUI
- **Architecture**: TCA (The Composable Architecture)
- **Dependencies**:
  - [TCA](https://github.com/pointfreeco/swift-composable-architecture)
  - [Lottie](https://github.com/airbnb/lottie-ios)
  - [ViewInspector](https://github.com/nalexn/ViewInspector) (Testing)

## 📱 Features

- Display Marvel characters with images and details
- Search functionality
- Infinite scrolling
- Error handling with retry capability
- Loading states with animations
- Offline support (coming soon)

## 🏛 Architecture

### Modular Design
- **Core Modules**: Reusable foundation libraries
- **Feature Modules**: Isolated feature implementations
- **Design System**: Consistent UI components
- **Configuration**: Environment and secrets management

### Key Principles
- Clean Architecture
- SOLID principles
- Protocol-oriented design
- Dependency injection
- Modular development
- Comprehensive testing

## 🔍 Code Quality

### SwiftLint Configuration
Each module has its own SwiftLint configuration tailored to its specific needs:

- **Config**: Strict configuration rules
- **CoreModels**: Type safety focused rules
- **CoreNetworking**: Network-specific rules
- **DesignSystem**: UI-focused rules
- **FeatureHeroList**: Feature-specific rules

### Testing Strategy
- Unit tests for business logic
- UI tests using ViewInspector
- Network layer mocking
- Test plans for different scenarios

## 🚀 Getting Started

### Prerequisites
- Xcode 15.0+
- iOS 15.0+
- Swift 6.0+
- SwiftLint (`brew install swiftlint`)

### Installation
1. Clone the repository:
```bash
git clone https://github.com/vcapilladeveloper/Marvelous.git
```

2. Install SwiftLint:
```bash
brew install swiftlint
```

3. Set up Marvel API keys:
   - Create `Secrets.xcconfig` in `Config/`
   - Add your Marvel API keys:
```
MARVEL_PUBLIC_KEY=your_public_key
MARVEL_PRIVATE_KEY=your_private_key
```

4. Open `Marvelous-iOS.xcodeproj`

5. Build and run

## 🧪 Testing

Run tests using:
- Xcode's Test Navigator
- Command line: `xcodebuild test -scheme Marvelous-iOS`

## 📚 Module Documentation

Each module contains its own README with detailed documentation:

- [Config](Config/README.md): Secrets and configuration management
- [CoreModels](CoreModels/README.md): Data models and types
- [CoreNetworking](CoreNetworking/README.md): Networking layer
- [DesignSystem](DesignSystem/README.md): UI components
- [FeatureHeroList](FeatureHeroList/README.md): Character list feature

## 👥 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgements

- [Marvel API](https://developer.marvel.com/)
- [TCA](https://github.com/pointfreeco/swift-composable-architecture)
- [Lottie](https://github.com/airbnb/lottie-ios)
- [ViewInspector](https://github.com/nalexn/ViewInspector)