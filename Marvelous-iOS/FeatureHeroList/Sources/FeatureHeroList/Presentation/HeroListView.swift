import SwiftUI
import ComposableArchitecture
import DesignSystem
import CoreModels

public struct HeroListView: View {
    let store: StoreOf<HeroListFeature>

    public init(store: StoreOf<HeroListFeature>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }, content: { viewStore in
            NavigationStack {
                content(viewStore: viewStore)
                    .navigationTitle("Marvel Heroes")
                    .searchable(
                        text: viewStore.binding(
                            get: \.searchQuery,
                            send: { .searchQueryChanged($0) }
                        )
                    )
                    .onAppear { viewStore.send(.onAppear) }
                    .overlay {
                        if let error = viewStore.errorMessage {
                            ErrorView(
                                message: error,
                                onRetry: { viewStore.send(.onAppear) }
                            )
                        }
                    }
            }
        })
    }

    @ViewBuilder
    private func content(viewStore: ViewStoreOf<HeroListFeature>) -> some View {
        ScrollView {
            heroGrid(viewStore: viewStore)
            if viewStore.isLoading {
                LoadingView().padding()
            }
        }
    }

    @ViewBuilder
    private func heroGrid(viewStore: ViewStoreOf<HeroListFeature>) -> some View {
        LazyVGrid(columns: DSGrid.threeColumns, spacing: DSSpacing.large) {
            ForEach(viewStore.heroes) { hero in
                HeroAvatarCard(name: hero.name, imageURL: hero.thumbnail.url)
                    .onAppear {
                        if hero == viewStore.heroes.last {
                            viewStore.send(.loadMore)
                        }
                    }
            }
        }
        .padding()
    }
}
