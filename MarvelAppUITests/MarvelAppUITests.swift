//
//  MarvelAppUITests.swift
//  MarvelAppUITests
//
//  Created by zafer ertas on 4.06.2020.
//  Copyright © 2020 zafer ertas. All rights reserved.
//

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
        
        sleep(2) //wait for the tableview items to load
        
        let mainTableView = app.tables.element(matching: .table, identifier: "mainTableView")
        let tableCells = mainTableView.cells

        XCTAssertEqual(tableCells.count, 20) //Default number of items
    }

    func testDetailViewsExist() {
        
        sleep(2) //wait fo tableview to load
        
        //tap the first cell
        app.tables.cells.element(boundBy: 0).tap()
                
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
