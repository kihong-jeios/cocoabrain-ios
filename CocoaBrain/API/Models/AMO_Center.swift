//
//  AMO_Center.swift
//  CocoaBrain
//
//  Created by Kai on 2/26/25.
//

import UIKit

class AMO_Center: Mappable {
    var succeess: Bool = false
    var message: String = ""
    var data: AMO_CenterData = AMO_CenterData(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        succeess <- map["succeess"]
        message <- map["message"]
        data <- map["data"]
    }
}


class AMO_CenterData: Mappable {
    var totalCount: Double = 0
    var totalPages: Double = 0
    var currentPage: Double = 0
    var list: [AMO_CenterList] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        totalCount <- map["totalCount"]
        totalPages <- map["totalPages"]
        currentPage <- map["currentPage"]
        list <- map["list"]
    }
}

class AMO_CenterList: Mappable {
    var id: Double = 0
    var name: String = ""
    var contact: String = ""
    var centerType: CenterType = .oc
    var comment: String? = nil
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        contact <- map["contact"]
        centerType <- map["centerType"]
        comment <- map["comment"]
    }
}
