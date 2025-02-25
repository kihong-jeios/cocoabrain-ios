//
//  AMO_Status.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

class AMO_Status: Mappable {
    var code: Int = 0
    var message: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        code <- map["code"]
        message <- map["message"]
    }
}
