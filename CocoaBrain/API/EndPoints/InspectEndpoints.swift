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
        case .postTmtBw(params: _):
            return "/api/v1/inspect/tmt-bw"
        case .getTmtBW(inspectId: let inspectId, params: _):
            return "/api/v1/inspect/tmt-bw/\(inspectId)"
        case .postCdt(params: _):
            return "/api/v1/inspect/cdt"
        case .postKdsq(params: _):
            return "/api/v1/inspect/kdsq"
        case .postAdditionalInfo(params: _):
            return "/api/v1/inspect/kdsq/additionalinfo"
        case .getKdsq(inspectId: let inspectId, params: _):
            return "/api/v1/inspect/kdsq/\(inspectId)"
        case .getKdsqSurvey(inspectId: _, params: _):
            return "/api/v1/inspect/kdsq/additionalinfo"
            
        case .getInspect(params: _):
            return "/api/v1/inspect"
        case .getInspectUserId(userId: let userId, params: _):
            return "/api/v1/inspect/\(userId)"
        case .getInspectLastDate(userId: let userId, params: _):
            return "/api/v1/inspect/\(userId)/last-date"
            
        case .postPmtMemorizeImage(params: _):
            return "/api/v1/inspect/pmt/memorize/image"
        case .postPmtMatchingUpload(params: _):
            return "/api/v1/inspect/pmt/image/matching/upload"
        case .postPmtComplete(params: _):
            return "/api/v1/inspect/pmt/complete"
        case .getPmtImages(params: _):
            return "/api/v1/inspect/pmt/image"
        case .deletePmtImages(params: _):
            return "/api/v1/inspect/pmt/image"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postTmtBw(params: _):
            return .post
        case .getTmtBW(inspectId: _, params: _):
            return .get
        case .postCdt(params: _):
            return .post
        case .postKdsq(params: _):
            return .post
        case .postAdditionalInfo(params: _):
            return .post
        case .getKdsq(inspectId: _, params: _):
            return .get
        case .getKdsqSurvey(inspectId: _, params: _):
            return .get
        case .getInspect(params: _):
            return .get
        case .getInspectUserId(userId: _, params: _):
            return .get
        case .getInspectLastDate(userId: _, params: _):
            return .get
        case .postPmtMemorizeImage(params: _):
            return .post
        case .postPmtMatchingUpload(params: _):
            return .post
        case .postPmtComplete(params: _):
            return .post
        case .getPmtImages(params: _):
            return .get
        case .deletePmtImages(params: _):
            return .delete
        }
    }
    
    var body: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .postTmtBw(params: let params):
            body = params
        case .getTmtBW(inspectId: _, params: let params):
            body = params
        case .postCdt(params: let params):
            body = params
        case .postKdsq(params: let params):
            body = params
        case .postAdditionalInfo(params: let params):
            body = params
        case .getKdsq(inspectId: _, params: let params):
            body = params
        case .getKdsqSurvey(inspectId: _, params: let params):
            body = params
        case .getInspect(params: let params):
            body = params
        case .getInspectUserId(userId: _, params: let params):
            body = params
        case .getInspectLastDate(userId: _, params: let params):
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
