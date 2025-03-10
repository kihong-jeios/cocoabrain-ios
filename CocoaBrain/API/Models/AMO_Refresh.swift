//
//  AMO_Refresh.swift
//  CocoaBrain
//
//  Created by Kai on 2/27/25.
//

import UIKit

class AMO_Refresh: Mappable {
    var succeess: Bool = false
    var message: String = ""
    var data: AMO_RefreshData = AMO_RefreshData(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        succeess <- map["succeess"]
        message <- map["message"]
        data <- map["data"]
    }
}

class AMO_RefreshData: Mappable {
    var accessToken: String = ""
    var refreshToken: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        accessToken <- map["accessToken"]
        refreshToken <- map["refreshToken"]
    }
}

