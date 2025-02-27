//
//  AMO_Login.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

enum Role: String {
    case user = "user"
    case dr = "doctor"
    case nr = "nurse"
    case tp = "therapist"
    case ga = "general admin"
    case sa = "super admin"
}

enum CenterType: String {
    case oc = "operation center" // 운영센터
    case ec = "examination center" // 검진센터
    case sh = "specialty hospital" // 전문병원
    case gh = "general hospital" // 일반병원
    case nh = "nursing hospital" // 요양병원
    case ch = "care home" // 요양원
    case swf = "Senior welfare facilities" // 노인복지시설
    case etc = "etc" // 기타
}

class AMO_Login: Mappable {
    var success: Bool = false
    var message: String = ""
    var data: AMO_LoginData = AMO_LoginData(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        data <- map["data"]
    }
}

class AMO_LoginData: Mappable {
    var admin: AMO_Admin = AMO_Admin(JSON: [:])!
    var token: AMO_Token = AMO_Token(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        admin <- map["admin"]
        token <- map["token"]
    }
}

class AMO_Admin: Mappable {
    var id: Double = 0
    var name: String = ""
    var email: String = ""
    var enabled: Bool = true
    var role: Role = .dr
    var initPassword: Bool = false
    var contact: String = ""
    var createdAt: String?
    var centerId: Double = 0
    var centerName: String = ""
    var centerType: CenterType = .oc
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        enabled <- map["enabled"]
        role <- map["role"]
        initPassword <- map["initPassword"]
        contact <- map["contact"]
        createdAt <- map["createdAt"]
        centerId <- map["centerId"]
        centerName <- map["centerName"]
        centerType <- map["centerType"]
    }
}

class AMO_Token: Mappable {
    var accessToken: String = ""
    var refreshToken: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        accessToken <- map["accessToken"]
        refreshToken <- map["refreshToken"]
    }
}


