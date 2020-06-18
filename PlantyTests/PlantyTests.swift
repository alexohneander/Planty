//
//  PlantyTests.swift
//  PlantyTests
//
//  Created by Alex Wellnitz on 16.06.20.
//  Copyright © 2020 Wellcom. All rights reserved.
//

import XCTest
@testable import Planty

class PlantyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //MARK: Plant Class Tests
    
    // Confirm that the Plant initializer returns a Plant object when passed valid parameters.
    func testPlantInitializationSucceeds() {
        
        // Empty Description
        let emptyDescription = Plant.init(name: "Test", description: nil, id: "Test")
        XCTAssertNotNil(emptyDescription)
        
        // Empty Name String
        let emptyNamePlant = Plant.init(name: "", description: nil, id: "Test")
        XCTAssertNil(emptyNamePlant)
        
        // Empty Id String
        let emptyIdPlant = Plant.init(name: "Test", description: nil, id: "")
        XCTAssertNil(emptyIdPlant)
    }
}
