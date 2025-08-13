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
│               └── Loading.json
└── Tests/
   └── DesignSystemTests/
      ├── LoadingViewTests.swift
      └── ArticleCardTests.swift
```

### 📦 Key Components

#### 1. Foundation Layer
- **Typography**: Consistent text styles and fonts
- **Color Palette**: Brand colors with fallback support
- **Spacing**: Standardized spacing values
- **Grid**: Layout guidelines and components

#### 2. Components
- **PrimaryButton**: Main action button component
- **ArticleCard**: News article display card
- **ErrorView**: Error state handling
- **LoadingView**: Loading state with Lottie animation
- **Shimmer**: Loading state animation effect

#### Example Usage
```swift
import DesignSystem

ArticleCard(article: article)
   .accessibilityLabel(article.title)
```

## Accessibility
- All components include `accessibilityLabel` and `accessibilityHint`
- Colors and typography meet minimum contrast requirements
- Recommended to test with VoiceOver and Dynamic Type
- Semantic element grouping for better screen reader experience

## Good Practices
- Reusable and documented components
- No force unwraps in production code
- Visual and accessibility tests
- Consistent design tokens

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme DesignSystem
```

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
    public static let background = Color("Background")
    public static let surface = Color("Surface")
    public static let textPrimary = Color("TextPrimary")
    public static let textSecondary = Color("TextSecondary")
    public static let brand = Color("Brand")
    public static let error = Color("Error")
    public static let shadow = Color("Shadow")
}
```

### Accessibility
- Proper accessibility labels and traits
- Support for Dynamic Type
- VoiceOver optimization
- Semantic element grouping
- High contrast support

### Best Practices
1. ✅ SwiftUI previews for all components
2. ✅ Consistent spacing and typography
3. ✅ Reusable components
4. ✅ Accessibility support
5. ✅ Unit tests with ViewInspector

## Component Details

### ArticleCard
- Displays article information in a card format
- Supports optional images with fallback
- Responsive layout for different content lengths
- Accessibility labels for all elements

### PrimaryButton
- Consistent button styling across the app
- Support for different states (enabled, disabled, loading)
- Accessibility traits and labels
- Touch target size compliance

### LoadingView
- Lottie animation integration
- Customizable loading messages
- Accessibility support for screen readers
- Smooth animation transitions

### Shimmer
- Loading state animation effect
- Customizable shimmer properties
- Performance optimized
- SwiftUI modifier pattern

## Testing

The module includes UI component tests using ViewInspector:
- Component rendering tests
- Interaction tests
- Accessibility tests
- State management tests
- Visual regression tests

## Dependencies
- Lottie (Airbnb) for animations
- ViewInspector for testing
- iOS 16.6+ support
- Swift 6.0+

## Areas for Improvement

1. **Theme Support**
   - Add dark mode support
   - Implement theme switching
   - Color asset integration

2. **Component Coverage**
   - Add more common components
   - Create component variants
   - Add component documentation

3. **Testing**
   - Increase test coverage
   - Add snapshot tests
   - Add accessibility tests

4. **Documentation**
   - Add DocC documentation
   - Create usage examples
   - Add component catalog

5. **Performance**
   - Optimize animations
   - Reduce memory footprint
   - Cache commonly used resources

6. **Accessibility**
   - Add more accessibility features
   - Support for different accessibility modes
   - Accessibility testing tools integration

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target and used by all feature modules for consistent UI components.

## Design System Guidelines

### Typography Scale
- Use predefined typography tokens
- Maintain consistent hierarchy
- Support Dynamic Type scaling

### Color Usage
- Use semantic color names
- Ensure sufficient contrast ratios
- Support both light and dark themes

### Spacing System
- Use predefined spacing values
- Maintain consistent rhythm
- Scale appropriately for different screen sizes

### Component Composition
- Build complex UIs from simple components
- Maintain consistent behavior patterns
- Ensure accessibility compliance
