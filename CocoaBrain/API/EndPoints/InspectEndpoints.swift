//
//  InspectEndpoints.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

enum InspectEndpoints {
    case postTmtBw(params: Parameters)
    case getTmtBW(inspectId: String, params: Parameters)
    case postCdt(params: Parameters)
    case postKdsq(params: Parameters)
    case postAdditionalInfo(params: Parameters)
    case getKdsq(inspectId: String, params: Parameters)
    case getKdsqSurvey(inspectId: String, params: Parameters)
    
    case getInspect(params: Parameters)
    case getInspectUserId(userId: String, params: Parameters)
    case getInspectLastDate(userId: String, params: Parameters)
    
    case postPmtMemorizeImage(params: Parameters)
    case postPmtMatchingUpload(params: Parameters)
    case postPmtComplete(params: Parameters)
    case getPmtImages(params: Parameters)
    case deletePmtImages(params: Parameters)
}

extension InspectEndpoints: Endpoint {

    var path: String {
        switch self {
        case .postTmtBw(params: let params):
            return "/api/v1/inspect/tmt-bw"
        case .getTmtBW(inspectId: let inspectId, params: let params):
            return "/api/v1/inspect/tmt-bw/\(inspectId)"
        case .postCdt(params: let params):
            return "/api/v1/inspect/cdt"
        case .postKdsq(params: let params):
            return "/api/v1/inspect/kdsq"
        case .postAdditionalInfo(params: let params):
            return "/api/v1/inspect/kdsq/additionalinfo"
        case .getKdsq(inspectId: let inspectId, params: let params):
            return "/api/v1/inspect/kdsq/\(inspectId)"
        case .getKdsqSurvey(inspectId: let inspectId, params: let params):
            return "/api/v1/inspect/kdsq/additionalinfo"
            
        case .getInspect(params: let params):
            return "/api/v1/inspect"
        case .getInspectUserId(userId: let userId, params: let params):
            return "/api/v1/inspect/\(userId)"
        case .getInspectLastDate(userId: let userId, params: let params):
            return "/api/v1/inspect/\(userId)/last-date"
            
        case .postPmtMemorizeImage(params: let params):
            return "/api/v1/inspect/pmt/memorize/image"
        case .postPmtMatchingUpload(params: let params):
            return "/api/v1/inspect/pmt/image/matching/upload"
        case .postPmtComplete(params: let params):
            return "/api/v1/inspect/pmt/complete"
        case .getPmtImages(params: let params):
            return "/api/v1/inspect/pmt/image"
        case .deletePmtImages(params: let params):
            return "/api/v1/inspect/pmt/image"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postTmtBw(params: let params):
            return .post
        case .getTmtBW(inspectId: let inspectId, params: let params):
            return .get
        case .postCdt(params: let params):
            return .post
        case .postKdsq(params: let params):
            return .post
        case .postAdditionalInfo(params: let params):
            return .post
        case .getKdsq(inspectId: let inspectId, params: let params):
            return .get
        case .getKdsqSurvey(inspectId: let inspectId, params: let params):
            return .get
        case .getInspect(params: let params):
            return .get
        case .getInspectUserId(userId: let userId, params: let params):
            return .get
        case .getInspectLastDate(userId: let userId, params: let params):
            return .get
        case .postPmtMemorizeImage(params: let params):
            return .post
        case .postPmtMatchingUpload(params: let params):
            return .post
        case .postPmtComplete(params: let params):
            return .post
        case .getPmtImages(params: let params):
            return .get
        case .deletePmtImages(params: let params):
            return .delete
        }
    }
    
    var body: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .postTmtBw(params: let params):
            body = params
        case .getTmtBW(inspectId: let inspectId, params: let params):
            body = params
        case .postCdt(params: let params):
            body = params
        case .postKdsq(params: let params):
            body = params
        case .postAdditionalInfo(params: let params):
            body = params
        case .getKdsq(inspectId: let inspectId, params: let params):
            body = params
        case .getKdsqSurvey(inspectId: let inspectId, params: let params):
            body = params
        case .getInspect(params: let params):
            body = params
        case .getInspectUserId(userId: let userId, params: let params):
            body = params
        case .getInspectLastDate(userId: let userId, params: let params):
            body = params
        case .postPmtMemorizeImage(params: let params):
            body = params
        case .postPmtMatchingUpload(params: let params):
            body = params
        case .postPmtComplete(params: let params):
            body = params
        case .getPmtImages(params: let params):
            body = params
        case .deletePmtImages(params: let params):
            body = params
        }
        return body
    }

}
