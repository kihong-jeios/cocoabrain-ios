//
//  AMO_InspectDetail.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

class AMO_InspectDetail: Mappable {
    var succeess: Bool = false
    var message: String = ""
    var data: AMO_InspectDetailData = AMO_InspectDetailData(JSON: [:])!
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        succeess <- map["succeess"]
        message <- map["message"]
        data <- map["data"]
    }
}

class AMO_InspectDetailData: Mappable {
    var user: AMO_UserData = AMO_UserData(JSON: [:])!
    var lastInspectDate: String = ""
    var inspectList: [AMO_InspectDetailDataList] = []
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        user <- map["user"]
        lastInspectDate <- map["lastInspectDate"]
        inspectList <- map["inspectList"]
    }
}

class AMO_InspectDetailDataList: Mappable {
    var date: String = ""
    var cdt: AMO_InspectDetailDataListValue? = nil
    var kdsq: AMO_InspectDetailDataListValue? = nil
    var tmtBw: AMO_InspectDetailDataListValue? = nil
    var pmt: AMO_InspectDetailDataListValue? = nil
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        date <- map["date"]
        cdt <- map["cdt"]
        kdsq <- map["kdsq"]
        tmtBw <- map["tmtBw"]
        pmt <- map["pmt"]
    }
}

class AMO_InspectDetailDataListValue: Mappable {
    var inspectId: Int = 0
    var status: String = ""
    var duration: Double = 0
    var result: Double = 0
    var imagUrl: String = ""
    var level: String = ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        inspectId <- map["inspectId"]
        status <- map["status"]
        duration <- map["duration"]
        result <- map["result"]
        imagUrl <- map["imagUrl"]
        level <- map["level"]
    }
}

