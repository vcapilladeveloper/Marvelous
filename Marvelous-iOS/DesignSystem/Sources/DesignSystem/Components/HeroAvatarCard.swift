import SwiftUI

public struct HeroAvatarCard: View, Identifiable {
    public let id = UUID()
    let name: String
    let imageURL: URL?

    public init(name: String, imageURL: URL?) {
        self.name = name
        self.imageURL = imageURL
    }

    public var body: some View {
        VStack(alignment: .center, spacing: DSSpacing.sm) {
            AsyncRemoteImage(url: imageURL, width: 110, height: 130, cornerRadius: 12)
            Text(name)
                .font(DSTypography.heroName)
                .foregroundColor(DSPalette.textPrimary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(name))
    }
}

#Preview("HeroAvatarCard") {
    HeroAvatarCard(name: "Spider-Man", imageURL: URL(string: "https://picsum.photos/200"))
        .padding()
        .background(DSPalette.background)
}
