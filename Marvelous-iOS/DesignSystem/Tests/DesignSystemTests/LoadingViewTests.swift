import XCTest
import SwiftUI
import ViewInspector
@testable import DesignSystem

@MainActor
final class LoadingViewTests: XCTestCase {
    func testShowsDefaultTitle() throws {
        let sut = LoadingView()
        let identifier = try sut.inspect().vStack().first?.accessibilityIdentifier()
        XCTAssertEqual(identifier, "loadingAnimation")
    }

    func testCustomTitle() throws {
        let sut = LoadingView(title: "Fetching Heroes", animationName: "Test")
        let title = try sut.inspect().vStack().text(1).string()
        let animationIdentifier = try sut.inspect().vStack().first?.accessibilityIdentifier()
        XCTAssertEqual(title, "Fetching Heroes")
        XCTAssertEqual(animationIdentifier, "defaultAnimation")
    }
}
