//
//  UserEndPoints.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

enum UserEndPoints {
    case getUser(userId: String, params: Parameters)
    case updateUser(userId: String, params: Parameters)
    case getUsers(params: Parameters)
    case postUser(params: Parameters)
    case patchUser(userId: String, params: Parameters)
    case getMembers(params: Parameters)
}

extension UserEndPoints: Endpoint {
    
    var path: String {
        switch self {
        case .getUser(userId: let userId, params: _):
            return "/api/v1/users/\(userId)"
        case .updateUser(userId: let userId, params: _):
            return "/api/v1/users/\(userId)"
        case .getUsers(params: _):
            return "/api/v1/users"
        case .postUser(params: _):
            return "/api/v1/users"
        case .patchUser(userId: let userId, params: _):
            return "/api/v1/users/\(userId)/enable"
        case .getMembers(params: _):
            return "/api/v1/users/me/members"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getUser(userId: _, params: _):
            return .get
        case .updateUser(userId: _, params: _):
            return .put
        case .getUsers(params: _):
            return .get
        case .postUser(params: _):
            return .post
        case .patchUser(userId: _, params: _):
            return .patch
        case .getMembers(params: _):
            return .get
        }
    }
    
    var body: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .getUser(userId: _, params: let params):
            body = params
        case .updateUser(userId: _, params: let params):
            body = params
        case .getUsers(params: let params):
            body = params
        case .postUser(params: let params):
            body = params
        case .patchUser(userId: _, params: let params):
            body = params
        case .getMembers(params: let params):
            body = params
        }
        return body
    }
}
