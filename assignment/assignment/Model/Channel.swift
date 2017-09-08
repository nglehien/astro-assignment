//
//  Channel.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit

class Channel: NSObject, JsonObjectSerializable, KeyValueDescription {
    
    // MARK: Property
    public private(set) var _id:Int = 0
    public private(set) var siId:Int = 0
    public private(set) var stbNumber:Int = 0
    public private(set) var title:String = ""
    public private(set) var logo:URL? = nil;
    
    // MARK: initialize
    
    public init(_id:Int, number:Int, title:String, logo:URL) {
        self._id = _id;
        self.stbNumber = number;
        self.title = title;
    }
    
    internal required init(representation: [String : AnyObject]) {
        self._id        = representation["channelId"] as! Int
        self.title      = representation["channelTitle"] as! String
        // Due to "siChannelId" value is String
        self.siId       = Int(representation["siChannelId"] as! String)!
        self.stbNumber  = Int(representation["channelStbNumber"] as! String)!
        
    }
    
    func keyValueDescription() -> [String : String] {
        return [
            "id": String(self._id),
            "siId" : String(self.siId),
            "stbNumber": String(self.stbNumber),
            "title": self.title
        ]
    }
}
