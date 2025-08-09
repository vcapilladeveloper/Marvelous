import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    public init(_ title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(DSTypography.body)
                .foregroundColor(.white)
                .padding(.vertical, DSSpacing.sm)
                .frame(maxWidth: .infinity)
                .background(DSPalette.brand)
                .cornerRadius(12)
        }
        .accessibilityLabel(Text(title))
        .accessibilityAddTraits(.isButton)
    }
}

#Preview("PrimaryButton") {
    PrimaryButton("Retry", action: {})
        .padding()
}
