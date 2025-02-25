//
//  AdminEndPoints.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

enum AdminEndPoints {
    case getAdminAccount(adminId: String, params: Parameters)
    case putAdminAccount(adminId: String, params: Parameters)
    case patchAdminAccount(adminId: String, params: Parameters)
    case getMyInformation(centerId: String, params: Parameters)
    case getAllCenters(params: Parameters)
    case postCenter(params: Parameters)
    case postSpeechtext(params: Parameters)
}

extension AdminEndPoints: Endpoint {
    var path: String {
        switch self {
        case .getAdminAccount(adminId: let adminId, params: let params):
            return "/api/v1/admin/accounts/\(adminId)"
        case .putAdminAccount(adminId: let adminId, params: let params):
            return "/api/v1/admin/accounts/\(adminId)"
        case .patchAdminAccount(adminId: let adminId, params: let params):
            return "/api/v1/admin/accounts/\(adminId)/enable"
        case .getMyInformation(centerId: let centerId, params: let params):
            return "/api/v1/admin/accounts/me"
        case .getAllCenters(params: let params):
            return "/api/v1/admin/accounts/me"
        case .postCenter(params: let params):
            return "/api/v1/admin/accounts/me/members"
        case .postSpeechtext(params: let params):
            return "/api/v1/admin/speech/speechtext"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAdminAccount(adminId: let adminId, params: let params):
            return .get
        case .putAdminAccount(adminId: let adminId, params: let params):
            return .put
        case .patchAdminAccount(adminId: let adminId, params: let params):
            return .patch
        case .getMyInformation(centerId: let centerId, params: let params):
            return .get
        case .getAllCenters(params: let params):
            return .get
        case .postCenter(params: let params):
            return .post
        case .postSpeechtext(params: let params):
            return .post
        }
    }
    
    var body: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .getAdminAccount(adminId: let adminId, params: let params):
            body = params
        case .putAdminAccount(adminId: let adminId, params: let params):
            body = params
        case .patchAdminAccount(adminId: let adminId, params: let params):
            body = params
        case .getMyInformation(centerId: let centerId, params: let params):
            body = params
        case .getAllCenters(params: let params):
            body = params
        case .postCenter(params: let params):
            body = params
        case .postSpeechtext(params: let params):
            body = params
        }
        return body
    }
    

}
