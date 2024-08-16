//
//  RetrospectiveUITests.swift
//  RetrospectiveUITests
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import XCTest

final class RetrospectiveUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        func testSessionDetailViewNavigation() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                XCTAssertTrue(app.navigationBars["Session Detail"].exists, "Should navigate to Session Detail view.")
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
        
        func testAddingNewComment() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                let addButton = app.buttons["Yeni Ekle"]
                if addButton.exists {
                    addButton.tap()
                    let textField = app.textFields["CommentInput"]
                    XCTAssertTrue(textField.exists, "Comment input field should be visible after tapping Yeni Ekle.")
                } else {
                    XCTFail("Add button not found in Session Detail view.")
                }
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        func testSessionDetailViewNavigation() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                XCTAssertTrue(app.navigationBars["Session Detail"].exists, "Should navigate to Session Detail view.")
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
        
        func testAddingNewComment() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                let addButton = app.buttons["Yeni Ekle"]
                if addButton.exists {
                    addButton.tap()
                    let textField = app.textFields["CommentInput"]
                    XCTAssertTrue(textField.exists, "Comment input field should be visible after tapping Yeni Ekle.")
                } else {
                    XCTFail("Add button not found in Session Detail view.")
                }
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        func testSessionDetailViewNavigation() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                XCTAssertTrue(app.navigationBars["Session Detail"].exists, "Should navigate to Session Detail view.")
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
        
        func testAddingNewComment() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                let addButton = app.buttons["Yeni Ekle"]
                if addButton.exists {
                    addButton.tap()
                    let textField = app.textFields["CommentInput"]
                    XCTAssertTrue(textField.exists, "Comment input field should be visible after tapping Yeni Ekle.")
                } else {
                    XCTFail("Add button not found in Session Detail view.")
                }
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
                func testSessionDetailViewNavigation() throws {
                    let app = XCUIApplication()
                    app.launch()
                    let sessionCell = app.tables.cells.element(boundBy: 0)
                    if sessionCell.exists {
                        sessionCell.tap()
                        XCTAssertTrue(app.navigationBars["Session Detail"].exists, "Should navigate to Session Detail view.")
                    } else {
                        XCTFail("No session cell found to tap.")
                    }
                }
                
                func testAddingNewComment() throws {
                    let app = XCUIApplication()
                    app.launch()
                    let sessionCell = app.tables.cells.element(boundBy: 0)
                    if sessionCell.exists {
                        sessionCell.tap()
                        let addButton = app.buttons["Yeni Ekle"]
                        if addButton.exists {
                            addButton.tap()
                            let textField = app.textFields["CommentInput"]
                            XCTAssertTrue(textField.exists, "Comment input field should be visible after tapping Yeni Ekle.")
                        } else {
                            XCTFail("Add button not found in Session Detail view.")
                        }
                    } else {
                        XCTFail("No session cell found to tap.")
                    }
                }
            }
            func testSessionDetailViewNavigation() throws {
                let app = XCUIApplication()
                app.launch()
                let sessionCell = app.tables.cells.element(boundBy: 0)
                if sessionCell.exists {
                    sessionCell.tap()
                    XCTAssertTrue(app.navigationBars["Session Detail"].exists, "Should navigate to Session Detail view.")
                } else {
                    XCTFail("No session cell found to tap.")
                }
            }
            func testAddingNewComment() throws {
                let app = XCUIApplication()
                app.launch()
                let sessionCell = app.tables.cells.element(boundBy: 0)
                if sessionCell.exists {
                    sessionCell.tap()
                    let addButton = app.buttons["Yeni Ekle"]
                    if addButton.exists {
                        addButton.tap()
                        let textField = app.textFields["CommentInput"]
                        XCTAssertTrue(textField.exists, "Comment input field should be visible after tapping Yeni Ekle.")
                    } else {
                        XCTFail("Add button not found in Session Detail view.")
                    }
                } else {
                    XCTFail("No session cell found to tap.")
                }
            }
        }
        func testSessionDetailViewNavigation() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                XCTAssertTrue(app.navigationBars["Session Detail"].exists, "Should navigate to Session Detail view.")
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
        
        func testAddingNewComment() throws {
            let app = XCUIApplication()
            app.launch()
            let sessionCell = app.tables.cells.element(boundBy: 0)
            if sessionCell.exists {
                sessionCell.tap()
                let addButton = app.buttons["Yeni Ekle"]
                if addButton.exists {
                    addButton.tap()
                    let textField = app.textFields["CommentInput"]
                    XCTAssertTrue(textField.exists, "Comment input field should be visible after tapping Yeni Ekle.")
                } else {
                    XCTFail("Add button not found in Session Detail view.")
                }
            } else {
                XCTFail("No session cell found to tap.")
            }
        }
    }
}
