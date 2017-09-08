//
//  ChannelAPI.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit

class ChannelAPI: AstroRestAPI<Channel> {
    
    static var instance:ChannelAPI = ChannelAPI()
    
    private override init() {
        
    }
    
    override func apiPath() -> String {
        return "/ams/v3/getChannels"
    }
    
    public func getById(id:Int, completion: @escaping (Channel?, Error?) -> Void) {
        let parameters:[String:Int] = ["channelId" : id]
        
        self.getByParameters(parameters: parameters) { (channel, error) in
            completion(channel, error)
        }
    }
}
