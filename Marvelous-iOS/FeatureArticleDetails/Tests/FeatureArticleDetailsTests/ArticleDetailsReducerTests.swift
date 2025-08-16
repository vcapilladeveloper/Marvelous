import XCTest
import ComposableArchitecture
import CoreModels
@testable import FeatureArticleDetails

final class ArticleDetailsReducerTests: XCTestCase {
    
    /// These tests intentionally avoid using `setUp` and `tearDown` methods.
    /// Each test case creates its own `Article` and `TestStore` instance,
    /// keeping the setup explicit and localized. This improves readability
    /// and makes it easier to understand the initial state and expectations
    /// of each test in isolation.
    
    func testShareToggle() async {
        let article = Article.mock
        let sut = await TestStore(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        }

        await sut.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }

    func testInitialState() async {
        let article = Article.mock
        let sut = await TestStore(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        }

        await sut.assert { state in
            state.article == article
            state.isShareSheetPresented == false
        }
    }

    func testShareToggleWithDifferentArticles() async {
        let article1 = Article.mock
        let article2 = Article(
            source: Source(id: "test", name: "Test Source"),
            author: "Test Author",
            title: "Test Title",
            description: "Test Description",
            url: "https://test.com",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2025-01-01T00:00:00Z",
            content: "Test Content"
        )

        let sut1 = await TestStore(initialState: .init(article: article1)) {
            ArticleDetailsFeature()
        }

        let sut2 = await TestStore(initialState: .init(article: article2)) {
            ArticleDetailsFeature()
        }

        await sut1.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut1.send(.shareDismissed) { $0.isShareSheetPresented = false }

        await sut2.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut2.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }

    func testShareToggleStatePersistence() async {
        let article = Article.mock
        let sut = await TestStore(initialState: .init(article: article)) {
            ArticleDetailsFeature()
        }

        await sut.send(.shareTapped) { $0.isShareSheetPresented = true }

        await sut.assert { state in
            state.isShareSheetPresented == true
        }

        await sut.send(.shareDismissed) { $0.isShareSheetPresented = false }

        await sut.assert { state in
            state.isShareSheetPresented == false
        }
    }

    func testArticleDetailsWithNilArticleFields() async {
        let articleWithNilFields = Article(
            source: nil,
            author: nil,
            title: nil,
            description: nil,
            url: nil,
            urlToImage: nil,
            publishedAt: nil,
            content: nil
        )

        let sut = await TestStore(initialState: .init(article: articleWithNilFields)) {
            ArticleDetailsFeature()
        }

        await sut.assert { state in
            state.article == articleWithNilFields
            state.isShareSheetPresented == false
        }

        await sut.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }

    func testArticleDetailsWithEmptyStrings() async {
        let articleWithEmptyStrings = Article(
            source: Source(id: "", name: ""),
            author: "",
            title: "",
            description: "",
            url: "",
            urlToImage: "",
            publishedAt: "",
            content: ""
        )

        let sut = await TestStore(initialState: .init(article: articleWithEmptyStrings)) {
            ArticleDetailsFeature()
        }

        await sut.assert { state in
            state.article == articleWithEmptyStrings
            state.isShareSheetPresented == false
        }

        await sut.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }

    func testArticleDetailsWithVeryLongContent() async {
        let longContent = String(repeating: "Very long article content that exceeds normal limits. ", count: 100)
        let articleWithLongContent = Article(
            source: Source(id: "test", name: "Test Source"),
            author: "Test Author",
            title: "Test Title with Very Long Content",
            description: longContent,
            url: "https://test.com",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2025-01-01T00:00:00Z",
            content: longContent
        )

        let sut = await TestStore(initialState: .init(article: articleWithLongContent)) {
            ArticleDetailsFeature()
        }

        await sut.assert { state in
            state.article == articleWithLongContent
            state.isShareSheetPresented == false
        }

        await sut.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }

    func testArticleDetailsWithSpecialCharacters() async {
        let specialContent = "Article with special chars: !@#$%^&*()_+-=[]{}|;':\",./<>?"
        let articleWithSpecialChars = Article(
            source: Source(id: "test", name: "Test Source"),
            author: "Test Author",
            title: specialContent,
            description: specialContent,
            url: "https://test.com",
            urlToImage: "https://test.com/image.jpg",
            publishedAt: "2025-01-01T00:00:00Z",
            content: specialContent
        )

        let sut = await TestStore(initialState: .init(article: articleWithSpecialChars)) {
            ArticleDetailsFeature()
        }

        await sut.assert { state in
            state.article == articleWithSpecialChars
            state.isShareSheetPresented == true
        }

        await sut.send(.shareTapped) { $0.isShareSheetPresented = true }
        await sut.send(.shareDismissed) { $0.isShareSheetPresented = false }
    }

    func testArticleDetailsStateEquality() async {
        let article1 = Article.mock
        let article2 = Article.mock

        let sut1 = await TestStore(initialState: .init(article: article1)) {
            ArticleDetailsFeature()
        }

        let sut2 = await TestStore(initialState: .init(article: article2)) {
            ArticleDetailsFeature()
        }

        let state1 = await sut1.state
        let state2 = await sut2.state

        XCTAssertEqual(state1.article, state2.article)
        XCTAssertEqual(state1.isShareSheetPresented, state2.isShareSheetPresented)
    }
}
