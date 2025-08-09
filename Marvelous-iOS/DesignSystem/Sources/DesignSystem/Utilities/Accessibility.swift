import SwiftUI

public extension View {
    /// Convenience for marking tappable hero cells with a clear label.
    func heroCellAccessibility(name: String) -> some View {
        self.accessibilityElement(children: .combine)
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel(Text(name))
    }
}
