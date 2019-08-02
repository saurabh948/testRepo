//
//  Response.swift
//  EngineerAITest
//
//  Created by PCQ184 on 02/08/19.
//  Copyright © 2019 PCQ184. All rights reserved.
//

import Foundation
import SwiftyJSON

class Response: NSObject {
    
    var title           : String!   = ""
    var created_at      : String!   = ""
    var isPostSelected  : Bool      = false
    
    
    required init(dictionary: JSON) {
        if dictionary.isEmpty != true {
            self.title = dictionary["title"].stringValue
            if let createdAt = dictionary["created_at"].string {
                let date = PostDate.date(fromString: createdAt, withFormat: PostDateFormat.serverDateFormat)
                self.created_at = PostDate.string(fromDate: date!, withFormat: PostDateFormat.appDateFormat)
            }
        }
    }
}
