//
//  JsonObjectSerializable.swift
//  assignment
//
//  Created by Hien Nguyen on 9/7/17.
//  Copyright © 2017 Misfit. All rights reserved.
//

import UIKit

protocol JsonObjectSerializable {
    init(representation: [String : AnyObject])
}

protocol KeyValueDescription {
    func keyValueDescription() -> [String:String]
}
