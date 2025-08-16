import SwiftUI
import DesignSystem
import CoreModels
import ComposableArchitecture

public struct ArticleListView: View {
    let store: StoreOf<ArticleListFeature>
    let onArticleSelected: (Article) -> Void

    public init(
        store: StoreOf<ArticleListFeature>,
        onArticleSelected: @escaping (Article) -> Void
    ) {
        self.store = store
        self.onArticleSelected = onArticleSelected
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }, content: { viewStore in
            NavigationStack {
                content(viewStore: viewStore)
                    .navigationTitle("News")
                    .searchable(
                        text: viewStore.binding(
                            get: \.searchQuery,
                            send: { .searchQueryChanged($0) }
                        )
                    )
                    .onAppear { viewStore.send(.onAppear) }
                    .overlay { errorOverlay(viewStore: viewStore) }
                    .onChange(of: viewStore.selected) { article in
                        if let article {
                            onArticleSelected(article)
                            viewStore.send(.dismissDetail)
                        }
                    }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        })
    }

    @ViewBuilder
    private func content(viewStore: ViewStoreOf<ArticleListFeature>) -> some View {
        ScrollView {
            grid(viewStore: viewStore)
                .padding()
            if viewStore.isLoading {
                LoadingView()
                    .padding(.vertical)
            }
        }
    }

    @ViewBuilder
    private func grid(viewStore: ViewStoreOf<ArticleListFeature>) -> some View {
        let columns = DSGrid.threeColumns
        LazyVGrid(columns: columns, spacing: DSSpacing.large) {
            ForEach(viewStore.items) { article in
                articleCell(article, viewStore: viewStore)
                    .onTapGesture { viewStore.send(.didSelect(article)) }
                    .accessibilityAddTraits(.isButton)
                    .accessibilityHint("Double tap to view article details.")
                    .onAppear {
                        if article.id == viewStore.items.last?.id {
                            viewStore.send(.loadMore)
                        }
                    }
            }
        }
    }

    @ViewBuilder
    private func articleCell(_ article: Article, viewStore _: ViewStoreOf<ArticleListFeature>) -> some View {
        ArticleCard(
            title: article.title ?? "(No title)",
            imageURL: article.imageURL
        )
        .contentShape(Rectangle())
    }

    @ViewBuilder
    private func errorOverlay(viewStore: ViewStoreOf<ArticleListFeature>) -> some View {
        if let msg = viewStore.errorMessage {
            ZStack {
                Color(.systemBackground)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    ErrorView(message: msg, onRetry: { viewStore.send(.retry) })
                        .padding()
                    Spacer()
                }
            }
        } else {
            EmptyView()
        }
    }
}
