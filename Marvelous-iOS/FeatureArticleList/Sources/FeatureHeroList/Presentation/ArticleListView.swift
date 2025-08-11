import SwiftUI
import DesignSystem
import CoreModels
import ComposableArchitecture
import FeatureArticleDetails

public struct ArticleListView: View {
    let store: StoreOf<ArticleListFeature>
    public init(store: StoreOf<ArticleListFeature>) { self.store = store }

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
                    .sheet(
                        isPresented: viewStore.binding(
                            get: { $0.selected != nil },
                            send: { $0 ? .onAppear : .dismissDetail } // opening handled by didSelect; closing dismisses
                        ),
                        content: {
                            if let article = viewStore.selected {
                                ArticleDetailsView(
                                    store: Store(initialState: .init(article: article)) {
                                        ArticleDetailsFeature()
                                    }
                                )
                            }
                        }
                    )
            }
        })
    }

    // MARK: - Subviews

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
