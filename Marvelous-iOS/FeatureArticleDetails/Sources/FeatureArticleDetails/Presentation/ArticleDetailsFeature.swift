import Foundation
import ComposableArchitecture
import CoreModels

public struct ArticleDetailsFeature: Reducer {
    public struct State: Equatable, Sendable {
        public let article: Article
        public var isShareSheetPresented = false

        public init(article: Article) {
            self.article = article
        }
    }

    public enum Action: Equatable, Sendable {
        case onAppear
        case openInBrowserTapped
        case shareTapped
        case shareDismissed
    }

    public init() {}

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .none

            case .openInBrowserTapped:
                // Leave actual opening to the View layer via Environment/OpenURL
                return .none

            case .shareTapped:
                state.isShareSheetPresented = true
                return .none

            case .shareDismissed:
                state.isShareSheetPresented = false
                return .none
            }
        }
    }
}
