import XCTest
import SwiftUI
import ViewInspector
@testable import DesignSystem

@MainActor
final class LoadingViewTests: XCTestCase {
    func testShowsProgressViewWhenResourceMissing() throws {
        let sut = LoadingView(
            title: "Fallback Loading",
            animationName: "MissingAnimation"
        )

        let progressView = try sut.inspect().find(viewWithAccessibilityIdentifier: "defaultAnimation")
        XCTAssertNoThrow(try progressView.progressView())

        let text = try sut.inspect().find(text: "Fallback Loading")
        XCTAssertEqual(try text.string(), "Fallback Loading")

        XCTAssertThrowsError(try sut.inspect().find(viewWithAccessibilityIdentifier: "loadingAnimation"))
    }

    func testAccessibilityConfiguration() throws {
        let sut = LoadingView(title: "Accessibility Test")

        let vStack = try sut.inspect().vStack()
        XCTAssertEqual(try vStack.accessibilityLabel().string(), "Accessibility Test")
    }
}
