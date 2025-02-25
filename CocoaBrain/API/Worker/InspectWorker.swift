//
//  InspectWorker.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

class InspectWorker: NSObject {
    var endpoint: InspectEndpoints
    init(type: InspectEndpoints) {
        switch type {
        case .postTmtBw(let params):
            self.endpoint = InspectEndpoints.postTmtBw(params: params)
        case .getTmtBW(let inspectId, let params):
            self.endpoint = InspectEndpoints.getTmtBW(inspectId: inspectId, params: params)
        case .postCdt(let params):
            self.endpoint = InspectEndpoints.postCdt(params: params)
        case .postKdsq(let params):
            self.endpoint = InspectEndpoints.postKdsq(params: params)
        case .postAdditionalInfo(let params):
            self.endpoint = InspectEndpoints.postAdditionalInfo(params: params)
        case .getKdsq(let inspectId, let params):
            self.endpoint = InspectEndpoints.getKdsq(inspectId: inspectId, params: params)
        case .getKdsqSurvey(let inspectId, let params):
            self.endpoint = InspectEndpoints.getKdsqSurvey(inspectId: inspectId, params: params)
        case .getInspect(let params):
            self.endpoint = InspectEndpoints.getInspect(params: params)
        case .getInspectUserId(let userId, let params):
            self.endpoint = InspectEndpoints.getInspectUserId(userId: userId, params: params)
        case .getInspectLastDate(let userId, let params):
            self.endpoint = InspectEndpoints.getInspectLastDate(userId: userId, params: params)
        case .postPmtMemorizeImage(let params):
            self.endpoint = InspectEndpoints.postPmtMemorizeImage(params: params)
        case .postPmtMatchingUpload(let params):
            self.endpoint = InspectEndpoints.postPmtMatchingUpload(params: params)
        case .postPmtComplete(let params):
            self.endpoint = InspectEndpoints.postPmtComplete(params: params)
        case .getPmtImages(let params):
            self.endpoint = InspectEndpoints.getPmtImages(params: params)
        case .deletePmtImages(let params):
            self.endpoint = InspectEndpoints.deletePmtImages(params: params)
        }
    }

}
