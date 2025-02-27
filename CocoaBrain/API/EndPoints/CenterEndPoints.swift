//
//  CenterEndPoints.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

enum CenterEndPoints {
    case getCenter(centerId: String, params: Parameters)
    case putCenter(centerId: String, params: Parameters)
    case deleteCenter(centerId: String, params: Parameters)
    case getAllCenters(params: Parameters)
    case postCenter(params: Parameters)
}

extension CenterEndPoints: Endpoint {
    var path: String {
        switch self {
        case .getCenter(centerId: let centerId, params: _):
            return "/api/v1/center/\(centerId)"
        case .putCenter(centerId: let centerId, params: _):
            return "/api/v1/center/\(centerId)"
        case .deleteCenter(centerId: let centerId, params: _):
            return "/api/v1/center/\(centerId)"
        case .getAllCenters(params: _):
            return "/api/v1/center"
        case .postCenter(params: _):
            return "/api/v1/center"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getCenter(centerId: _, params: _):
            return .get
        case .putCenter(centerId: _, params: _):
            return .put
        case .deleteCenter(centerId: _, params: _):
            return .delete
        case .getAllCenters(params: _):
            return .get
        case .postCenter(params: _):
            return .post
        }
    }
    
    var body: Parameters {
        var body: Parameters = Parameters()
        switch self {
        case .getCenter(centerId: _, params: let params):
            body = params
        case .putCenter(centerId: _, params: let params):
            body = params
        case .deleteCenter(centerId: _, params: let params):
            body = params
        case .getAllCenters(params: let params):
            body = params
        case .postCenter(params: let params):
            body = params
        }
        return body
    }
    
    
}
