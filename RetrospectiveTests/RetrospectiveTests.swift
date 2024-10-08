//
//  RetrospectiveTests.swift
//  RetrospectiveTests
//
//  Created by Furkan Karaçam on 22.07.2024.
//

import XCTest
@testable import Retrospective

final class RetrospectiveTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        func testInitialization() throws {
            let sessionData = SessionData()
            XCTAssertNotNil(sessionData, "SessionData should be initialized successfully.")
        }
        
        func testSessionNameAssignment() throws {
            let sessionData = SessionData()
            sessionData.name = "Test Session"
            XCTAssertEqual(sessionData.name, "Test Session", "Session name should be assigned correctly.")
        }
        
        func testPerformanceExample() throws {
            self.measure {
                // Example of performance test
                let _ = (0...1000).map { $0 * $0 }
            }
        }
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        func testInitialization() throws {
            let sessionData = SessionData()
            XCTAssertNotNil(sessionData, "SessionData should be initialized successfully.")
        }
        
        func testSessionNameAssignment() throws {
            let sessionData = SessionData()
            sessionData.name = "Test Session"
            XCTAssertEqual(sessionData.name, "Test Session", "Session name should be assigned correctly.")
        }
        
        func testPerformanceExample() throws {
            self.measure {
                // Example of performance test
                let _ = (0...1000).map { $0 * $0 }
            }
        }
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        
        func testInitialization() throws {
            let sessionData = SessionData()
            XCTAssertNotNil(sessionData, "SessionData should be initialized successfully.")
        }
        
        func testSessionNameAssignment() throws {
            let sessionData = SessionData()
            sessionData.name = "Test Session"
            XCTAssertEqual(sessionData.name, "Test Session", "Session name should be assigned correctly.")
        }
        
        func testPerformanceExample() throws {
            self.measure {
                // Example of performance test
                let _ = (0...1000).map { $0 * $0 }
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            func testInitialization() throws {
                let sessionData = SessionData()
                XCTAssertNotNil(sessionData, "SessionData should be initialized successfully.")
            }
            
            func testSessionNameAssignment() throws {
                let sessionData = SessionData()
                sessionData.name = "Test Session"
                XCTAssertEqual(sessionData.name, "Test Session", "Session name should be assigned correctly.")
            }
            
            func testPerformanceExample() throws {
                self.measure {
                    // Example of performance test
                    let _ = (0...1000).map { $0 * $0 }
                }
            }
        }
        
        func testInitialization() throws {
            let sessionData = SessionData()
            XCTAssertNotNil(sessionData, "SessionData should be initialized successfully.")
        }
        
        func testSessionNameAssignment() throws {
            let sessionData = SessionData()
            sessionData.name = "Test Session"
            XCTAssertEqual(sessionData.name, "Test Session", "Session name should be assigned correctly.")
        }
        
        func testPerformanceExample() throws {
            self.measure {
                // Example of performance test
                let _ = (0...1000).map { $0 * $0 }
            }
        }
    }
    
    func testInitialization() throws {
        let sessionData = SessionData()
        XCTAssertNotNil(sessionData, "SessionData should be initialized successfully.")
    }
    
    func testSessionNameAssignment() throws {
        let sessionData = SessionData()
        sessionData.name = "Test Session"
        XCTAssertEqual(sessionData.name, "Test Session", "Session name should be assigned correctly.")
    }
}
