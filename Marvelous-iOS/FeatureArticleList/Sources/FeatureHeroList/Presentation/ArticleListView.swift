//
//  ArticleListView.swift
//  FeatureArticleList
//
//  Created by Victor Capilla Borrego on 10/8/25.
//


import SwiftUI
import DesignSystem
import CoreModels
import ComposableArchitecture

public struct ArticleListView: View {
    let store: StoreOf<ArticleListFeature>
    public init(store: StoreOf<ArticleListFeature>) { self.store = store }

    public var body: some View {
        WithViewStore(store, observe: { $0 }, content: { vs in
            NavigationStack {
                content(viewStore: vs)
                    .navigationTitle("News")
                    .searchable(
                        text: vs.binding(
                            get: \.searchQuery,
                            send: { .searchQueryChanged($0) }
                        )
                    )
                    .onAppear { vs.send(.onAppear) }
                    .overlay { errorOverlay(viewStore: vs) }
            }
        })
    }

    // MARK: - Subviews

    @ViewBuilder
    private func content(viewStore vs: ViewStoreOf<ArticleListFeature>) -> some View {
        ScrollView {
            grid(viewStore: vs)
                .padding()
            if vs.isLoading {
                LoadingView()
                    .padding(.vertical)
            }
        }
    }

    @ViewBuilder
    private func grid(viewStore vs: ViewStoreOf<ArticleListFeature>) -> some View {
        let columns = DSGrid.threeColumns
        LazyVGrid(columns: columns, spacing: DSSpacing.large) {
            ForEach(vs.items) { article in
                articleCell(article, viewStore: vs)
                    .onAppear {
                        if article.id == vs.items.last?.id {
                            vs.send(.loadMore)
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
    private func errorOverlay(viewStore vs: ViewStoreOf<ArticleListFeature>) -> some View {
        if let msg = vs.errorMessage {
            ErrorView(message: msg, onRetry: { vs.send(.onAppear) })
        } else {
            EmptyView()
        }
    }
}
