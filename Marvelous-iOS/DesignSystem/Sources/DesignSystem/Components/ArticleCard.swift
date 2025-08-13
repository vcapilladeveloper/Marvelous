import SwiftUI

public struct ArticleCard: View, Identifiable {
    public let id = UUID()
    let title: String
    let imageURL: URL?

    public init(title: String, imageURL: URL?) {
        self.title = title
        self.imageURL = imageURL
    }

    public var body: some View {
        VStack(alignment: .center, spacing: DSSpacing.small) {
            AsyncRemoteImage(url: imageURL, width: 110, height: 130, cornerRadius: 12, accessibilityLabel: title)
            Text(title)
                .font(DSTypography.articleTitle)
                .foregroundColor(DSPalette.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(title))
    }
}

#Preview("ArticleCard") {
    ArticleCard(title: "Amazing sun", imageURL: URL(string: "https://picsum.photos/200"))
        .padding()
        .background(DSPalette.background)
}
