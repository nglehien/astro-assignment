//
//  EventAPITest.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import XCTest

class EventAPITest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.dateFormat = Constant.kTimeIntervalFormat
        let date:Date = dateFormat.date(from: "01:45:00")!
        
        print(date.timeIntervalSinceReferenceDate)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    
    func test_get_on_air_event_by_id() -> Void {
        let event:EventAPI = EventAPI()
        
        let expectation:XCTestExpectation = self.expectation(description: "get_by_id")
        event.getOnAirEventByChannelIds(channelIds: [1]) { (events, error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 30) { (error) in
            XCTAssertNil(error, error.debugDescription)
        }
    }
    
}
