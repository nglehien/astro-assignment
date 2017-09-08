//
//  ChannelAPITest.swift
//  assignmentTests
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import XCTest

class ChannelAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_Get_Channel_By_Id() {
        let expectation:XCTestExpectation = self.expectation(description: "get_by_id")
        ChannelAPI.instance.getById(id: 1) { (chanel, error) in
            XCTAssertNil(error)
            XCTAssertNotNil(chanel)
            XCTAssertEqual(chanel?.title, "HBO")
            XCTAssertEqual(chanel?.stbNumber, 411)
            XCTAssertEqual(chanel?.siId, 998)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }
    
    func test_Get_Channel_All() {
        let expectation:XCTestExpectation = self.expectation(description: "get_by_id")
        ChannelAPI.instance.getAll { (chanels, error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }
}
