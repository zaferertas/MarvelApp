
import XCTest

class MarvelAppUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        app.launch()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        super.tearDown()
    }

    func testInitialViewsExist() throws {
        
        XCTAssert(app.navigationBars["Marvel Heroes"].exists)
        XCTAssert(app.activityIndicators.element.isEnabled)
        XCTAssert(app.tables.element(matching: .table, identifier: "mainTableView").exists)
    }

    func testTableViewCells() throws {
        
        let mainTableView = app.tables.element(matching: .table, identifier: "mainTableView")
        let tableCells = mainTableView.cells

        XCTAssertTrue(mainTableView.waitForExistence(timeout: 10))
        
        XCTAssertEqual(tableCells.count, 20) //Default number of items
    }

    func testDetailViewsExist() {
        
        let cell = app.tables.cells.firstMatch
        XCTAssertTrue(cell.waitForExistence(timeout: 10))
        
        cell.tap()
                
        XCTAssert(app.tables.otherElements["Name"].exists)
        XCTAssert(app.tables.otherElements["Image"].exists)
        XCTAssert(app.tables.otherElements["Description"].exists)
        
        app.swipeUp()
        
        XCTAssert(app.tables.otherElements["Comics"].exists)
        XCTAssert(app.tables.otherElements["Series"].exists)
        XCTAssert(app.tables.otherElements["Stories"].exists)
        XCTAssert(app.tables.otherElements["Events"].exists)
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
