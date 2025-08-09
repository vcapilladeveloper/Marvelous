import SwiftUI

public struct LoadingView: View {
    let title: String

    public init(title: String = "Loading…") {
        self.title = title
    }

    public var body: some View {
        VStack(spacing: DSSpacing.md) {
            // Prefer Lottie if the resource exists; otherwise show ProgressView
            if Bundle.module.url(forResource: "Loading", withExtension: "json") != nil {
                LottieView(name: "Loading")
                    .frame(width: 250, height: 120)
            } else {
                ProgressView()
                    .scaleEffect(1.2)
                Text(title)
                    .font(DSTypography.body)
                    .foregroundColor(DSPalette.textSecondary)
            }
        }
        .padding()
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(title))
    }
}

#Preview("LoadingView") {
    LoadingView()
}
