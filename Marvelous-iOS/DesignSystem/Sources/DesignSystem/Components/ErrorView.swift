import SwiftUI

public struct ErrorView: View {
    let message: String
    let retryTitle: String
    let onRetry: () -> Void

    public init(message: String, retryTitle: String = "Retry", onRetry: @escaping () -> Void) {
        self.message = message
        self.retryTitle = retryTitle
        self.onRetry = onRetry
    }

    public var body: some View {
        VStack(spacing: DSSpacing.large) {
            Text(message)
                .font(DSTypography.body)
                .foregroundColor(DSPalette.error)
                .multilineTextAlignment(.center)
            PrimaryButton(retryTitle, action: onRetry)
                .padding(.horizontal)
        }
        .padding()
        .accessibilityElement(children: .contain)
        .accessibilityLabel(Text(message))
    }
}

#Preview("ErrorView") {
    ErrorView(message: "Network error. Please try again.", onRetry: {})
        .padding()
}
