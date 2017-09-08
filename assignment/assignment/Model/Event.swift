//
//  Event.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit

class Event: NSObject, JsonObjectSerializable {
    public private(set) var _id:Int = 0
    public private(set) var channelId:Int = 0
    public private(set) var displayDateTimeUtc:Date = Date()
    public private(set) var displayDateTime:Date = Date()
    
    public private(set) var displayDuration:String = ""
    public private(set) var programmeTitle:String = ""
    public private(set) var shortSynopsis:String = ""
    
    public var duration:TimeInterval {
        let durationComponents:[String] = self.displayDuration.components(separatedBy: ":")
        // The duration format HH:mm:ss
        guard durationComponents.count == 3 else {
            return 0
        }
        
        let hours   = Int(durationComponents[0])! * 3600
        let minutes = Int(durationComponents[1])! * 60
        let seconds = Int(durationComponents[2])!
        
        return TimeInterval(hours + minutes + seconds)
    }
    
    // MARK: initialize
    
    internal required init(representation: [String : AnyObject]) {
        self._id        = Int(representation["eventID"] as! String)!
        self.channelId  = representation["channelId"] as! Int
        
        let dateFormat:DateFormatter = DateFormatter()
        dateFormat.dateFormat = Constant.kDatetimeFormatWithMilisecond
        
        self.displayDateTimeUtc = dateFormat.date(from: representation["displayDateTimeUtc"] as! String)!
        self.displayDateTime    = dateFormat.date(from: representation["displayDateTime"] as! String)!
        
        self.displayDuration    = representation["displayDuration"] as! String
        self.programmeTitle     = representation["programmeTitle"] as! String
        self.shortSynopsis      = representation["shortSynopsis"] as! String
    }
    
    

}
