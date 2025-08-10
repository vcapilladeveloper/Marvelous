import ComposableArchitecture

// Dependency registration for the Articles use case.
// We intentionally do not provide a concrete live implementation here,
// so the app composition layer must inject it (e.g., in @main).
enum FetchArticlesUseCaseKey: DependencyKey {
    static var liveValue: FetchArticlesUseCase {
        fatalError("FetchArticlesUseCase not set. Provide it at composition time.")
    }
    static var testValue: FetchArticlesUseCase {
        fatalError("FetchArticlesUseCase test value not set. Override in tests.")
    }
    static var previewValue: FetchArticlesUseCase {
        fatalError("FetchArticlesUseCase preview value not set. Override in previews.")
    }
}

public extension DependencyValues {
    var fetchArticlesUseCase: FetchArticlesUseCase {
        get { self[FetchArticlesUseCaseKey.self] }
        set { self[FetchArticlesUseCaseKey.self] = newValue }
    }
}
