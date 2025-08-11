import SwiftUI
import ComposableArchitecture
import CoreModels
import DesignSystem

public struct ArticleDetailsView: View {
    let store: StoreOf<ArticleDetailsFeature>
    @Environment(\.openURL) private var openURL

    public init(store: StoreOf<ArticleDetailsFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            ScrollView {
                VStack(alignment: .leading, spacing: DSSpacing.large) {
                    // Image
                    if let url = viewStore.article.imageURL {
                        AsyncRemoteImage(url: url, width: UIScreen.main.bounds.width - 32, height: 180, cornerRadius: 12)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }

                    // Title
                    Text(viewStore.article.title ?? "(No title)")
                        .font(DSTypography.title)
                        .foregroundColor(DSPalette.textPrimary)

                    // Meta
                    VStack(alignment: .leading, spacing: DSSpacing.extraSmall) {
                        if let source = viewStore.article.source?.name { metaRow(icon: "newspaper", text: source) }
                        if let author = viewStore.article.author, !author.isEmpty { metaRow(icon: "person.fill", text: author) }
                        if let iso = viewStore.article.publishedAt, let date = Date.iso8601(iso) {
                            metaRow(icon: "calendar", text: date.formatted(date: .abbreviated, time: .shortened))
                        }
                    }

                    // Description / Content
                    if let desc = viewStore.article.description, !desc.isEmpty {
                        Text(desc)
                            .font(DSTypography.body)
                            .foregroundColor(DSPalette.textSecondary)
                    }
                    if let content = viewStore.article.content, !content.isEmpty {
                        Text(content)
                            .font(DSTypography.body)
                            .foregroundColor(DSPalette.textPrimary)
                    }

                    // Actions
                    VStack(spacing: DSSpacing.medium) {
                        PrimaryButton("Open in Browser") {
                            store.send(.openInBrowserTapped)
                            if let url = viewStore.article.webURL { openURL(url) }
                        }
                        PrimaryButton("Share") {
                            store.send(.shareTapped)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle(viewStore.article.source?.name ?? "Article")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: viewStore.binding(
                get: \.isShareSheetPresented,
                send: { $0 ? .shareTapped : .shareDismissed }
            )) {
                if let url = viewStore.article.webURL {
                    ActivityView(activityItems: [url])
                }
            }
            .onAppear { store.send(.onAppear) }
        })
    }

    private func metaRow(icon: String, text: String) -> some View {
        HStack(spacing: DSSpacing.small) {
            Image(systemName: icon)
            Text(text)
        }
        .font(DSTypography.caption)
        .foregroundColor(DSPalette.textSecondary)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(text))
    }
}

// UIKit share sheet wrapper -> Maybe should be moved to a separate file?
// This allows us to present a share sheet for sharing URLs or other items.
// It uses UIViewControllerRepresentable to bridge UIKit's UIActivityViewController into SwiftUI.
private struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

#Preview("Article Details") {
    // swiftlint:disable force_try
    let article = try! JSONDecoder().decode(Article.self, from: Data(#"""
    {
      "source": {"id": "techcrunch","name": "TechCrunch"},
      "author": "Aria Alamalhodaei",
      "title": "SpaceX is building a water pipeline to Starbase – but access comes with some conditions | TechCrunch",
      "description": "The newest piece of infrastructure…",
      "url": "https://techcrunch.com/2025/08/07/spacex-is-building-a-water-pipeline-to-starbase-but-access-comes-with-some-conditions/",
      "urlToImage": "https://techcrunch.com/wp-content/uploads/2025/07/starbasec-city-spacex.jpg?resize=1200,510",
      "publishedAt": "2025-08-07T17:33:05Z",
      "content": "Full content…"
    }
    """#.utf8))
    // swiftlint:enable force_try
    return NavigationStack {
        ArticleDetailsView(store: Store(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        })
    }
}
