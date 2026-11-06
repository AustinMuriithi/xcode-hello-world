import XCTest

final class HelloWorldUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testAppLaunchesSuccessfully() throws {
        let predicate = NSPredicate(
            format: "state == %d",
            XCUIApplication.State.runningForeground.rawValue
        )
        let foregroundExpectation = XCTNSPredicateExpectation(predicate: predicate, object: app)
        let waitResult = XCTWaiter().wait(for: [foregroundExpectation], timeout: 15)
        XCTAssertEqual(waitResult, .completed, "App should be running in the foreground")
    }

    func testHelloWorldTextIsVisible() throws {
        let label = app.staticTexts["helloWorldLabel"]
        XCTAssertTrue(label.waitForExistence(timeout: 5), "Hello, World! label should be visible")
        XCTAssertEqual(label.label, "Hello, World!")
    }

    func testPersonalizedGreeting() throws {
        let nameField = app.textFields["nameField"]
        XCTAssertTrue(nameField.waitForExistence(timeout: 5))
        nameField.tap()
        nameField.typeText("Alex")
        app.buttons["sayHelloButton"].tap()

        XCTAssertEqual(app.staticTexts["helloWorldLabel"].label, "Hello, Alex!")
        XCTAssertFalse(app.staticTexts["nameError"].exists)
    }

    func testEmptyNameShowsErrorAndCanRecover() throws {
        app.buttons["sayHelloButton"].tap()
        XCTAssertTrue(app.staticTexts["nameError"].waitForExistence(timeout: 5))
        XCTAssertEqual(app.staticTexts["helloWorldLabel"].label, "Hello, World!")

        let nameField = app.textFields["nameField"]
        nameField.tap()
        nameField.typeText("Alex")
        app.buttons["sayHelloButton"].tap()

        XCTAssertFalse(app.staticTexts["nameError"].exists)
        XCTAssertEqual(app.staticTexts["helloWorldLabel"].label, "Hello, Alex!")
    }

    func testAppLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
