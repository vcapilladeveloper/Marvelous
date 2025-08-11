import XCTest
import ComposableArchitecture
import CoreModels
@testable import FeatureArticleDetails

final class ArticleDetailsReducerTests: XCTestCase {
    func testShareToggle() async {
        // swiftlint:disable force_try
        let article = try! JSONDecoder().decode(Article.self, from: Data(#"""
        { "title":"title", "url":"https://ex.com" }
        """#.utf8))
        // swiftlint:enable force_try
        let store = await TestStore(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        }

        await store.send(.shareTapped) { $0.isShareSheetPresented = true }
        await store.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }
}
