//
//  AdminWorker.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

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
        case .getAllCenters(params: let params):
            self.endpoint = AdminEndPoints.getAllCenters(params: params)
        case .postCenter(params: let params):
            self.endpoint = AdminEndPoints.postCenter(params: params)
        case .postSpeechtext(params: let params):
            self.endpoint = AdminEndPoints.postSpeechtext(params: params)
        }
    }
}
