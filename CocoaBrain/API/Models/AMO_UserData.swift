//
//  AMO_UserData.swift
//  CocoaBrain
//
//  Created by Kai on 3/3/25.
//

import UIKit

class AMO_User: Mappable {
    var success: Bool = false
    var message: String = ""
    var data: AMO_UserData = AMO_UserData(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}

class AMO_UserData: Mappable {
    var id: Int = 0
    var medicalNo: String = ""
    var name: String = ""
    var enabled: Bool = true
    var gender: Gender = .male
    var birth: String = ""
    
    var eduLevel: EduLevel? = nil
    var hasGraduated: Bool = false
    var contact: String = ""
    
    var guardianName: String? = nil
    var guardianType: GuardianType? = nil
    var guardianContact: String? = nil
    var centerId: Int = 0
    var centerName: String = ""
    var createdAt: String? = nil

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        medicalNo <- map["medicalNo"]
        name <- map["name"]
        enabled <- map["enabled"]
        gender <- map["gender"]
        birth <- map["birth"]
        eduLevel <- map["eduLevel"]
        hasGraduated <- map["hasGraduated"]
        contact <- map["contact"]
        guardianName <- map["guardianName"]
        guardianType <- map["guardianType"]
        guardianContact <- map["guardianContact"]
        centerId <- map["centerId"]
        centerName <- map["centerName"]
        createdAt <- map["createdAt"]
    }
}
