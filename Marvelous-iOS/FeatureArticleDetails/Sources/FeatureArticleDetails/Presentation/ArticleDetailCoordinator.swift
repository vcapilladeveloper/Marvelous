import SwiftUI
import CoreModels
import ComposableArchitecture

public struct ArticleDetailCoordinator: View {
    public let article: Article
    public init(article: Article) {
        self.article = article
    }

    public var body: some View {
        ArticleDetailsView(
            store: Store(
                initialState: ArticleDetailsFeature.State(article: article),
                reducer: {
                    ArticleDetailsFeature()
                }
            )
        )
    }
}
