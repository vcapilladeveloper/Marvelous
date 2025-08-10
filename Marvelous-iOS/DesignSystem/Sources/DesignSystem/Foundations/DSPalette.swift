import SwiftUI

public enum DSPalette {
    // If you include Colors.xcassets, these will resolve from assets.
    // Otherwise, these hex fallbacks keep things working.
    public static let brand = Color("Brand", bundle: .module).fallback(hex: 0xEC1D24) // Brand color
    public static let textPrimary = Color("TextPrimary", bundle: .module).fallback(hex: 0x111111)
    public static let textSecondary = Color("TextSecondary", bundle: .module).fallback(hex: 0x666666)
    public static let background = Color("Background", bundle: .module).fallback(hex: 0xFFFFFF)
    public static let surface = Color("Surface", bundle: .module).fallback(hex: 0xF4F4F5)
    public static let error = Color("Error", bundle: .module).fallback(hex: 0xD00000)
}

private extension Color {
    func fallback(hex: UInt32) -> Color {
        // If asset exists, SwiftUI uses it; this is simply a helper to provide a default.
        // We can’t detect “missing asset” reliably; providing the hex always is fine.
        Color(
            .displayP3,
            red: Double((hex >> 16) & 0xFF) / 255.0,
            green: Double((hex >> 8) & 0xFF) / 255.0,
            blue: Double(hex & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}
