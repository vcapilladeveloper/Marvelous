# DesignSystem Module

## Overview
The DesignSystem module provides a comprehensive set of UI components, styles, and animations for the Marvelous News iOS app. It implements a consistent design language using SwiftUI, follows atomic design principles, y promueve accesibilidad y buenas prácticas.

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
      └── LoadingViewTests.swift
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
- Todos los componentes incluyen `accessibilityLabel` y `accessibilityHint`.
- Colores y tipografía cumplen contraste mínimo recomendado.
- Se recomienda testear con VoiceOver y Dynamic Type.

## Good Practices
- Componentes reutilizables y documentados.
- Sin force unwraps en producción.
- Tests visuales y de accesibilidad.

## Testing
To run tests for this module:
```sh
xcodebuild test -scheme DesignSystem
```

#### 3. Resources
- Lottie animations for enhanced loading states
- (Optional) Color assets for theming

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

### Accessibility
- Proper accessibility labels and traits
- Support for Dynamic Type
- VoiceOver optimization
- Semantic element grouping

### Best Practices
1. ✅ SwiftUI previews for all components
2. ✅ Consistent spacing and typography
3. ✅ Reusable components
4. ✅ Accessibility support
5. ✅ Unit tests with ViewInspector

## Testing

The module includes UI component tests using ViewInspector:
- Component rendering tests
- Interaction tests
- Accessibility tests
- State management tests

## Dependencies
- Lottie (Airbnb) for animations
- ViewInspector for testing
- iOS 15.0+ support
- Swift 6.1+

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

## Integration
The module is integrated as a local Swift Package in the main Marvelous iOS app target.
