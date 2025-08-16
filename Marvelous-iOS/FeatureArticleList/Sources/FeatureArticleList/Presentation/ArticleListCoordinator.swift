import SwiftUI
import CoreModels
import ComposableArchitecture

public struct ArticleListCoordinator: View {
    let onArticleSelected: (Article) -> Void

    public init(onArticleSelected: @escaping (Article) -> Void) {
        self.onArticleSelected = onArticleSelected
    }

    public var body: some View {
        ArticleListView(
            store: Store(
                initialState: ArticleListFeature.State(),
                reducer: {
                    ArticleListFeature()
                }
            ),
            onArticleSelected: onArticleSelected
        )
    }
}
