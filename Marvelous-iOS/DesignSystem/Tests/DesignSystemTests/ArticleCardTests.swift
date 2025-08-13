import XCTest
import SwiftUI
import ViewInspector
@testable import DesignSystem
import CoreModels

@MainActor
final class ArticleCardTests: XCTestCase {
    func testArticleCardRendersWithValidData() throws {
        let imageURL = URL(string: "https://example.com/image.jpg")
        let sut = ArticleCard(title: "Test Article Title", imageURL: imageURL)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "Test Article Title")
    }

    func testArticleCardWithNilImageURL() throws {
        let sut = ArticleCard(title: "Test Article Title", imageURL: nil)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "Test Article Title")
    }

    func testArticleCardWithEmptyTitle() throws {
        let sut = ArticleCard(title: "", imageURL: nil)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "")
    }

    func testArticleCardWithLongTitle() throws {
        let longTitle = String(repeating: "Very long article title that should wrap to multiple lines ", count: 10)
        let sut = ArticleCard(title: longTitle, imageURL: nil)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, longTitle)
    }

    func testArticleCardWithSpecialCharacters() throws {
        let specialTitle = "Article with special chars: !@#$%^&*()_+-=[]{}|;':\",./<>?"
        let sut = ArticleCard(title: specialTitle, imageURL: nil)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, specialTitle)
    }

    func testArticleCardAccessibility() throws {
        let sut = ArticleCard(title: "Accessible Article", imageURL: nil)

        let accessibilityLabel = try sut.inspect().vStack().accessibilityLabel()
        XCTAssertEqual(try accessibilityLabel.string(), "Accessible Article")
    }

    func testArticleCardVStackConfiguration() throws {
        let sut = ArticleCard(title: "Test", imageURL: nil)

        let vStack = try sut.inspect().vStack()
        XCTAssertEqual(try vStack.alignment(), .center)

        let spacing = try vStack.spacing()
        XCTAssertEqual(spacing, DSSpacing.small)
    }

    func testArticleCardTextConfiguration() throws {
        let sut = ArticleCard(title: "Test Title", imageURL: nil)

        let text = try sut.inspect().vStack().text(1)
        XCTAssertEqual(try text.attributes().font(), DSTypography.articleTitle)
        XCTAssertEqual(try text.attributes().foregroundColor(), DSPalette.textPrimary)

        let lineLimit = try text.lineLimit()
        XCTAssertEqual(lineLimit, 2)

        let textAlignment = try text.multilineTextAlignment()
        XCTAssertEqual(textAlignment, .center)
    }

    func testArticleCardIdentifiable() {
        let sut = ArticleCard(title: "Test", imageURL: nil)

        XCTAssertNotNil(sut.id)
        XCTAssertTrue(sut.id is UUID)
    }

    func testArticleCardMultipleInstancesHaveDifferentIDs() {
        let card1 = ArticleCard(title: "First", imageURL: nil)
        let card2 = ArticleCard(title: "Second", imageURL: nil)

        XCTAssertNotEqual(card1.id, card2.id)
    }

    func testArticleCardWithHTTPSURL() throws {
        let httpsURL = URL(string: "https://secure.example.com/image.jpg")
        let sut = ArticleCard(title: "HTTPS Article", imageURL: httpsURL)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "HTTPS Article")
    }

    func testArticleCardWithHTTPURL() throws {
        let httpURL = URL(string: "http://example.com/image.jpg")
        let sut = ArticleCard(title: "HTTP Article", imageURL: httpURL)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "HTTP Article")
    }

    func testArticleCardWithVeryLongImageURL() throws {
        let longURLString = "https://example.com/" + String(repeating: "very-long-path/", count: 100) + "image.jpg"
        let longURL = URL(string: longURLString)
        let sut = ArticleCard(title: "Long URL Article", imageURL: longURL)

        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "Long URL Article")
    }
}
