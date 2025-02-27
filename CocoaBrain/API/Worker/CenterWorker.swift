//
//  CenterWorker.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

class CenterWorker: NSObject {
    var endpoint: CenterEndPoints
    init(type: CenterEndPoints) {
        switch type {
        case .getCenter(centerId: let centerId, params: let params):
            self.endpoint = CenterEndPoints.getCenter(centerId: centerId, params: params)
        case .putCenter(centerId: let centerId, params: let params):
            self.endpoint = CenterEndPoints.putCenter(centerId: centerId, params: params)
        case .deleteCenter(centerId: let centerId, params: let params):
            self.endpoint = CenterEndPoints.deleteCenter(centerId: centerId, params: params)
        case .getAllCenters(params: let params):
            self.endpoint = CenterEndPoints.getAllCenters(params: params)
        case .postCenter(params: let params):
            self.endpoint = CenterEndPoints.postCenter(params: params)
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
