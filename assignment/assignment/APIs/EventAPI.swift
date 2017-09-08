//
//  EventAPI.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit

class EventAPI: AstroRestAPI<Event> {
    
    static var instance:EventAPI = EventAPI()
    
    private override init() {
        
    }
    
    override func apiPath() -> String {
        return "/ams/v3/getEvents"
    }
    
    public func getOnAirEventByChannelIds(channelIds:[Int], startTime:Date, endTime:Date, completion: @escaping ([Event], Error?) -> Void) {
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.timeZone = TimeZone.current
        dateFormat.dateFormat = Constant.kDatetimeFormat
        
        // event parameters
        
        let parameters:[String:String] = [
            "channelId"     : channelIds.description,
            "periodStart"   : dateFormat.string(from: startTime),
            "periodEnd"     : dateFormat.string(from: endTime)
        ]
        
        self.query(parameters: parameters) { (events:[Event], error) in
            guard error == nil else {
                completion([], error)
                return;
            }
            
            // Incase the channel Id not found -> return nil
            guard events.count > 0 else {
                completion([], nil)
                return;
            }
            
            completion(events, nil)
        }
    }
}
