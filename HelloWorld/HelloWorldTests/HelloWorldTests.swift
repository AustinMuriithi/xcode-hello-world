import XCTest
@testable import HelloWorld

final class HelloWorldTests: XCTestCase {

    func testGreetingUsesName() {
        XCTAssertEqual(ContentView.greeting(for: "Alex"), "Hello, Alex!")
    }

    func testGreetingTrimsSurroundingWhitespace() {
        XCTAssertEqual(ContentView.greeting(for: "  Alex \n"), "Hello, Alex!")
    }

    func testGreetingRejectsEmptyOrWhitespaceOnlyName() {
        XCTAssertNil(ContentView.greeting(for: ""))
        XCTAssertNil(ContentView.greeting(for: " \n\t"))
    }
}
