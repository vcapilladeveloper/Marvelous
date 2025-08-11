import XCTest
import ComposableArchitecture
import CoreModels
@testable import FeatureArticleDetails

final class ArticleDetailsReducerTests: XCTestCase {
    func testShareToggle() async {
        guard let article = try JSONDecoder().decode(Article.self, from: Data(#"""
        { "title":"title", "url":"https://ex.com" }
        """#.utf8)) else {
            XCTFail("ERROR: Failed to decode sample article")
        }
        let store = await TestStore(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        }

        await store.send(.shareTapped) { $0.isShareSheetPresented = true }
        await store.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }
}
