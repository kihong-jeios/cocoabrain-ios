//
//  AMO_MyInformation.swift
//  CocoaBrain
//
//  Created by Kai on 3/5/25.
//

import UIKit

class AMO_MyInformation: Mappable {
    var succeess: Bool = false
    var message: String = ""
    var data: AMO_Admin = AMO_Admin(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        succeess <- map["succeess"]
        message <- map["message"]
        data <- map["data"]
    }
}
