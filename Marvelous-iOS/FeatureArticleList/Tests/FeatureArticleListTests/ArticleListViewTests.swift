import XCTest
import SwiftUI
import ViewInspector
@testable import FeatureArticleList

final class ArticleListViewTests: XCTestCase {
    func testEmptyStateAppearsWhenNoArticles() throws {
        let store = Store(initialState: ArticleListFeature.State()) {
            ArticleListFeature { _, _ in ([], 0) }
        }
        let view = ArticleListView(store: store)
        let exp = view.inspection.inspect { view in
            let text = try view.find(text: "No articles found")
            XCTAssertEqual(try text.string(), "No articles found")
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 1)
    }
}
