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
                    if let url = viewStore.article.imageURL {
                            AsyncRemoteImage(
                                url: url,
                                width: UIScreen.main.bounds.width - 32,
                                height: 180,
                                cornerRadius: 12,
                                accessibilityLabel: viewStore.article.title
                                    ?? "Article image"
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                        }

                        Text(viewStore.article.title ?? "(No title)")
                        .font(DSTypography.title)
                        .foregroundColor(DSPalette.textPrimary)
                        .accessibilityLabel(viewStore.article.title ?? "Article title")

                    VStack(alignment: .leading, spacing: DSSpacing.extraSmall) {
                            if let source = viewStore.article.source?.name {
                                metaRow(
                                    icon: "newspaper",
                                    text: source,
                                    hint: "Article source"
                                )
                            }
                            if let author = viewStore.article.author,
                                !author.isEmpty {
                                metaRow(
                                    icon: "person.fill",
                                    text: author,
                                    hint: "Article author"
                                )
                            }
                        if let iso = viewStore.article.publishedAt, let date = Date.iso8601(iso) {
                            metaRow(icon: "calendar", text: date.formatted(date: .abbreviated, time: .shortened), hint: "Published date")
                        }
                    }

                    if let desc = viewStore.article.description, !desc.isEmpty {
                        Text(desc)
                            .font(DSTypography.body)
                            .foregroundColor(DSPalette.textSecondary)
                            .accessibilityLabel(desc)
                    }
                    if let content = viewStore.article.content, !content.isEmpty {
                        Text(content)
                            .font(DSTypography.body)
                            .foregroundColor(DSPalette.textPrimary)
                            .accessibilityLabel(content)
                    }

                    VStack(spacing: DSSpacing.medium) {
                        PrimaryButton("Open in Browser", accessibilityHint: "Opens the full article in your default web browser.") {
                            store.send(.openInBrowserTapped)
                            if let url = viewStore.article.webURL { openURL(url) }
                        }

                        PrimaryButton("Share", accessibilityHint: "Shares the article with other apps.") {
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

    private func metaRow(icon: String, text: String, hint: String) -> some View {
        HStack(spacing: DSSpacing.small) {
            Image(systemName: icon)
            Text(text)
        }
        .font(DSTypography.caption)
        .foregroundColor(DSPalette.textSecondary)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(text)
        .accessibilityHint(hint)
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
    let article = Article.mock
    return NavigationStack {
        ArticleDetailsView(store: Store(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        })
    }
}
