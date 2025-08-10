import Foundation
import ComposableArchitecture
import CoreModels
import DesignSystem

@Reducer
public struct HeroListFeature: Sendable {
    @ObservableState
    public struct State: Equatable {
        public var heroes: [Hero] = []
        public var isLoading = false
        public var errorMessage: String?
        public var searchQuery: String = ""
        public var canLoadMore = true
        public var page = 0

        public init() {}
    }

    public enum Action: Equatable, BindableAction {
        case onAppear
        case loadMore
        case searchQueryChanged(String)
        case heroesResponse(TaskResult<[Hero]>)
        case binding(BindingAction<State>)
    }

    @Dependency(\.fetchHeroesUseCase) var fetchHeroesUseCase

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard state.heroes.isEmpty else { return .none }
                state.isLoading = true
                state.errorMessage = nil
                return .run { [query = state.searchQuery] send in
                    await send(.heroesResponse(TaskResult {
                        try await fetchHeroesUseCase.execute(limit: 20, offset: 0, query: query)
                    }))
                }

            case .loadMore:
                guard !state.isLoading, state.canLoadMore else { return .none }
                state.isLoading = true
                state.page += 1
                return .run { [page = state.page, query = state.searchQuery] send in
                    let offset = page * 20
                    await send(.heroesResponse(TaskResult {
                        try await fetchHeroesUseCase.execute(limit: 20, offset: offset, query: query)
                    }))
                }

            case let .searchQueryChanged(query):
                state.searchQuery = query
                state.page = 0
                state.heroes = []
                state.canLoadMore = true
                return .send(.onAppear)

            case let .heroesResponse(.success(newHeroes)):
                state.isLoading = false
                if newHeroes.isEmpty {
                    state.canLoadMore = false
                } else {
                    state.heroes.append(contentsOf: newHeroes)
                }
                return .none

            case let .heroesResponse(.failure(error)):
                state.isLoading = false
                state.errorMessage = error.localizedDescription
                return .none

            case .binding:
                return .none
            }
        }
    }
}
