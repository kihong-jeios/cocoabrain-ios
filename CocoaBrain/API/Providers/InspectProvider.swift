//
//  InspectProvider.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit
import PromiseKit
import Alamofire

class InspectProvider: NSObject {

    func getInspect(userId: String) -> Promise<AMO_InspectDetail> {
        let params: Parameters = [:]
        let worker = InspectWorker.init(type: .getInspectUserId(userId: userId, params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_InspectDetail>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
}
