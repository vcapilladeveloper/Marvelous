import SwiftUI

public struct AsyncRemoteImage: View {
    @Environment(\.colorScheme) private var colorScheme
    let url: URL?
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let accessibilityLabel: String

    public init(url: URL?, width: CGFloat, height: CGFloat, cornerRadius: CGFloat = 10, accessibilityLabel: String) {
        self.url = url
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
        self.accessibilityLabel = accessibilityLabel
    }

    public var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                Rectangle()
                    .fill(DSPalette.surface)
                    .frame(width: width, height: height)
                    .cornerRadius(cornerRadius)
                    .shimmer()
            case .success(let image):
                image.resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(cornerRadius)
            case .failure:
                ZStack {
                    Rectangle().fill(DSPalette.surface)
                    Image(systemName: "photo")
                        .font(.title3)
                        .foregroundColor(DSPalette.textSecondary)
                }
                .frame(width: width, height: height)
                .cornerRadius(cornerRadius)
            @unknown default:
                EmptyView()
            }
        }
        .shadow(color: DSPalette.shadow.opacity(0.4), radius: 4, x: 4, y: 4)
        .accessibilityLabel(Text(accessibilityLabel))
        .accessibilityAddTraits(.isImage)
    }
}

#Preview("AsyncRemoteImage") {
    AsyncRemoteImage(url: URL(string: "https://picsum.photos/200"), width: 100, height: 120, accessibilityLabel: "Placeholder image")
        .padding()
        .background(DSPalette.background)
}
