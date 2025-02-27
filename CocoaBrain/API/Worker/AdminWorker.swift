//
//  AdminWorker.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

class AdminWorker: NSObject {
    var endpoint: AdminEndPoints
    init(type: AdminEndPoints) {
        switch type {
        case .getAdminAccount(adminId: let adminId, params: let params):
            self.endpoint = AdminEndPoints.getAdminAccount(adminId: adminId, params: params)
        case .putAdminAccount(adminId: let adminId, params: let params):
            self.endpoint = AdminEndPoints.putAdminAccount(adminId: adminId, params: params)
        case .patchAdminAccount(adminId: let adminId, params: let params):
            self.endpoint = AdminEndPoints.patchAdminAccount(adminId: adminId, params: params)
        case .getMyInformation(centerId: let centerId, params: let params):
            self.endpoint = AdminEndPoints.getMyInformation(centerId: centerId, params: params)
        case .postSpeechtext(params: let params):
            self.endpoint = AdminEndPoints.postSpeechtext(params: params)
        case .login(params: let params):
            self.endpoint = AdminEndPoints.login(params: params)
        case .refresh(params: let params):
            self.endpoint = AdminEndPoints.refresh(params: params)
        }
    }
    
    var request: DataRequest {
        return AF.request(self.endpoint.fullURL,
                          method: self.endpoint.method,
                          parameters: self.endpoint.body,
                          encoding: self.endpoint.encoding,
                          headers: self.endpoint.headers)
    }
}
