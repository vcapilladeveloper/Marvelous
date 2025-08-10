import ComposableArchitecture

private enum FetchHeroesUseCaseKey: DependencyKey, Sendable {
    static let liveValue: FetchHeroesUseCase = {
        fatalError("FetchHeroesUseCase not set")
    }()
}

public extension DependencyValues {
    var fetchHeroesUseCase: FetchHeroesUseCase {
        get { self[FetchHeroesUseCaseKey.self] }
        set { self[FetchHeroesUseCaseKey.self] = newValue }
    }
}
