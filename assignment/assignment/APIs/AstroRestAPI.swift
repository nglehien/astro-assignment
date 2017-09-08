//
//  AstroRestAPI.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit
import Alamofire

class AstroRestAPI<T:JsonObjectSerializable> : NSObject {
    
    // astro apis endpoint
    internal func apiPath() -> String {
        return ""
    }
    
    internal func query(parameters:Parameters?, completion: @escaping ([T], Error?) -> Void) {
        let url:URLConvertible = "\(Constant.astroEndPoint)\(self.apiPath())"
        Alamofire.request(url, parameters:parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success:
                    // Due to all of response is array
                    /*
                     * Format: response = {code, message, array}
                     * => Find array to get the expected response data.
                     */
                    let value:[String:AnyObject] = response.result.value as! [String:AnyObject]
                    let responseCode:Int = Int(value["responseCode"] as! String)!
                    
                    guard responseCode == 200 else {
                        completion([], nil)
                        return
                    }
                    
                    var responseData:[AnyObject] = []
                    value.forEach({ (key:String, item:AnyObject) in
                        if item is [AnyObject] {
                            responseData = item as! [AnyObject]
                            return
                        }
                    })

                    let realData:[T] = responseData.map({ (element:AnyObject) -> T in
                        let rawJSon:[String:AnyObject] = element as! [String : AnyObject]
                        return T(representation: rawJSon)
                    })
                    
                    completion(realData, nil)
                    break
                case .failure(let error):
                    completion([], error)
                    break
                }
        }
    }
    
    public func getByParameters(parameters:Parameters, completion: @escaping (T?, Error?) -> Void) {
        self.query(parameters: parameters) { (data, error) in
            guard error == nil else {
                completion(nil, error)
                return;
            }
            
            // Incase the channel Id not found -> return nil
            guard data.count == 1 else {
                completion(nil, error)
                return;
            }
            
            completion(data[0], error)
        }
    }
    
    public func getAll(completion: @escaping ([T], Error?) -> Void) {
        self.query(parameters: nil) { (data:[T], error:Error?) in
            guard error == nil else {
                completion([], error)
                return;
            }
            
            // Incase the channel Id not found -> return nil
            guard data.count > 0 else {
                completion([], error)
                return;
            }
            
            completion(data, error)
        }
    }
}
