import SwiftUI
import Config
import CoreNetworking
import CoreModels
import DesignSystem
import FeatureArticleList
import ComposableArchitecture

@main
struct MarvelousiOSApp: App {
    @State private var errorMessage: String?
    private let secrets: SecretsProvider?

    // Compose the feature at the app boundary
    private let store: StoreOf<ArticleListFeature>?

    init() {
        do {
            let secrets = try Secrets()
            self.secrets = secrets

            // Ensure we have a NewsAPI key
            let apiKey = secrets.newsAPIKey

            // Build infrastructure and repository
            let api = NewsAPI(apiKey: apiKey, client: APIClient())
            let repo = NewsArticlesRepository(api: api)

            // Wire the TCA feature with a closure dependency
            let feature = ArticleListFeature { query, page, pageSize in
                try await repo.fetchArticles(query: query, page: page, pageSize: pageSize)
            }

            self.store = Store(initialState: .init(), reducer: { feature })
        } catch {
            self.secrets = nil
            self.errorMessage = "Failed to load secrets. Configure your keys (NewsAPI) in Info.plist or your Config package."
            self.store = nil
        }
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if let errorMessage {
                    ErrorView(message: errorMessage, onRetry: {})
                        .padding()
                } else if let store {
                    ArticleListView(store: store)
                } else {
                    LoadingView() // Should not happen; included as a safety fallback
                }
            }
        }
    }
}
