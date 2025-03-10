//
//  AMO_UserList.swift
//  CocoaBrain
//
//  Created by Kai on 3/3/25.
//

import UIKit

class AMO_UserInspects: Mappable {
    var success: Bool = false
    var message: String = ""
    var data: AMO_UserInspectData = AMO_UserInspectData(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}

class AMO_UserInspectData: Mappable {
    var totalCount: Int = 0
    var totalPages: Int = 0
    var currentPage: Int = 0
    var list: [AMO_UserInspectListData] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        totalCount <- map["totalCount"]
        totalPages <- map["totalPages"]
        currentPage <- map["currentPage"]
        list <- map["list"]
    }
}

class AMO_UserInspectListData: Mappable {
    var id: Int = 0
    var name: String = ""
    var gender: Gender = .male
    var birth: String = ""
    var medicalNo: String = ""
    var inspectDate: String? = nil
    var statusSummary: [InspectType: InspectStatus]?
    var count: Int = 0
    var enabled: Bool = true
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        gender <- (map["gender"], EnumTransform<Gender>())
        birth <- map["birth"]
        medicalNo <- map["medicalNo"]
        inspectDate <- map["inspectDate"]
        statusSummary <- (map["statusSummary"], EnumDictionaryTransform<InspectType, InspectStatus>())
        count <- map["count"]
        enabled <- map["enabled"]
    }
}

