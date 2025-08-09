import XCTest
import SwiftUI
import ViewInspector
@testable import DesignSystem

@MainActor
final class LoadingViewTests: XCTestCase {
    func testShowsDefaultTitle() throws {
        let sut = LoadingView()
        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "Loading…")
    }

    func testCustomTitle() throws {
        let sut = LoadingView(title: "Fetching Heroes")
        let title = try sut.inspect().vStack().text(1).string()
        XCTAssertEqual(title, "Fetching Heroes")
    }
}
