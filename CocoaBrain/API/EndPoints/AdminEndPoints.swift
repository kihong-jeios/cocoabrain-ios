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
    case postSpeechtext(params: Parameters)
    
    case login(params: Parameters)
    case refresh(params: Parameters)
}

extension AdminEndPoints: Endpoint {
    var path: String {
        switch self {
        case .getAdminAccount(adminId: let adminId, params: _):
            return "/api/v1/admin/accounts/\(adminId)"
        case .putAdminAccount(adminId: let adminId, params: _):
            return "/api/v1/admin/accounts/\(adminId)"
        case .patchAdminAccount(adminId: let adminId, params: _):
            return "/api/v1/admin/accounts/\(adminId)/enable"
        case .getMyInformation(centerId: _, params: _):
            return "/api/v1/admin/accounts/me"
        case .postSpeechtext(params: _):
            return "/api/v1/admin/speech/speechtext"
        case .login(params: _):
            return "/api/v1/admin/login"
        case .refresh(params: _):
            return "/api/v1/admin/refresh"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getAdminAccount(adminId: _, params: _):
            return .get
        case .putAdminAccount(adminId: _, params: _):
            return .put
        case .patchAdminAccount(adminId: _, params: _):
            return .patch
        case .getMyInformation(centerId: _, params: _):
            return .get
        case .postSpeechtext(params: _):
            return .post
        case .login(params: _):
            return .post
        case .refresh(params: _):
            return .post
        }
    }
    
    var body: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .getAdminAccount(adminId: _, params: let params):
            body = params
        case .putAdminAccount(adminId: _, params: let params):
            body = params
        case .patchAdminAccount(adminId: _, params: let params):
            body = params
        case .getMyInformation(centerId: _, params: let params):
            body = params
        case .postSpeechtext(params: let params):
            body = params
        case .login(params: let params):
            body = params
        case .refresh(params: let params):
            body = params
        }
        return body
    }
    

}
