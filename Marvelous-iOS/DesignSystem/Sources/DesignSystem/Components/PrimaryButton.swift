import SwiftUI

public struct PrimaryButton: View {
    let title: String
    let accessibilityHint: String?
    let action: () -> Void

    public init(_ title: String, accessibilityHint: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.accessibilityHint = accessibilityHint
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(DSTypography.body)
                .foregroundColor(.white)
                .padding(.vertical, DSSpacing.small)
                .frame(maxWidth: .infinity)
                .background(DSPalette.brand)
                .cornerRadius(12)
        }
        .accessibilityLabel(Text(title))
        .accessibilityHint(Text(accessibilityHint ?? ""))
        .accessibilityAddTraits(.isButton)
    }
}

#Preview("PrimaryButton") {
    PrimaryButton("Retry", action: {})
        .padding()
}
