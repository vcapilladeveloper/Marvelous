# DesignSystem Module

## Overview
The DesignSystem module provides a comprehensive set of UI components, styles, and animations for the Marvelous News iOS app. It implements a consistent design language using SwiftUI, follows atomic design principles, and promotes accessibility and best practices.

## Architecture

### 🏗 Structure
```
DesignSystem/
├── Sources/
│   └── DesignSystem/
│       ├── Components/
│       │   ├── PrimaryButton.swift
│       │   ├── ArticleCard.swift
│       │   ├── ErrorView.swift
│       │   ├── LoadingView.swift
│       │   ├── LottieView.swift
│       │   └── Shimmer.swift
│       ├── Foundations/
│       │   ├── DSTypography.swift
│       │   ├── DSPalette.swift
│       │   ├── DSSpacing.swift
│       │   └── DSGrid.swift
│       └── Resources/
│           └── Animations/
│           |   └── Loading.json
│           └── Colors.xcassets/
└── Tests/
   └── DesignSystemTests/
      └── LoadingViewTests.swift
```

### 📦 Key Components

#### 1. Foundation Layer
- **Typography**: Consistent text styles and fonts.
- **Color Palette**: Brand colors with support for Light and Dark modes.
- **Spacing**: Standardized spacing values.
- **Grid**: Layout guidelines and components.

#### 2. Components
- **PrimaryButton**: Main action button component.
- **ArticleCard**: News article display card.
- **ErrorView**: A view for displaying error states.
- **LoadingView**: A loading state view using a Lottie animation.
- **LottieView**: A UIKit wrapper for using Lottie animations in SwiftUI.
- **Shimmer**: A loading animation effect.

#### 3. Resources
- **Animations/Loading.json**: The Lottie animation file.
- **Colors.xcassets**: The color asset catalog, defining colors for Light and Dark themes.

## Implementation Details

### Design Tokens
```swift
public enum DSSpacing {
    public static let xs: CGFloat = 4
    public static let sm: CGFloat = 8
    public static let md: CGFloat = 12
    public static let lg: CGFloat = 16
    public static let xl: CGFloat = 24
}

public enum DSTypography {
    public static let title: Font = .system(.title3, design: .rounded).weight(.bold)
    public static let body: Font = .system(size: 18, weight: .semibold, design: .rounded)
    public static let caption: Font = .system(.caption, design: .rounded)
    public static let heroName: Font = .system(size: 14, weight: .semibold, design: .rounded)
}
```

### Color System
```swift
public enum DSPalette {
    public static let brand = Color("Brand", bundle: .module)
    public static let textPrimary = Color("TextPrimary", bundle: .module)
    public static let textSecondary = Color("TextSecondary", bundle: .module)
    public static let background = Color("Background", bundle: .module)
    public static let surface = Color("Surface", bundle: .module)
    public static let error = Color("Error", bundle: .module)
    public static let shadow = Color("Shadow", bundle: .module)
}
```

### Accessibility
- All components include proper accessibility labels and traits.
- Support for Dynamic Type.
- VoiceOver optimization.
- Semantic element grouping.
- It is recommended to test with VoiceOver and Dynamic Type.

### Best Practices
1. ✅ SwiftUI previews for all components.
2. ✅ Consistent spacing and typography.
3. ✅ Reusable and composable components.
4. ✅ Strong accessibility support.
5. ✅ Unit tests with ViewInspector.

## Testing
The module includes UI component tests using ViewInspector for:
- Component rendering.
- Interaction logic.
- Accessibility properties.
- State management.

## Dependencies
- Lottie (for animations)
- ViewInspector (for testing)
- Requires iOS 16.0+
- Swift 6.0+

## Areas for Improvement

1. **Theme Support**: Implement a more robust theme-switching mechanism.
2. **Component Coverage**: Add more common components and variants.
3. **Testing**: Increase test coverage with snapshot tests and dedicated accessibility tests.
4. **Documentation**: Add DocC documentation and create a component catalog/gallery.
5. **Performance**: Optimize animations and reduce the memory footprint of components.

## Integration
The module is integrated as a local Swift Package and is used by the feature modules.