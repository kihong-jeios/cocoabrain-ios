//
//  AdminProvider.swift
//  CocoaBrain
//
//  Created by Kai on 3/5/25.
//

import UIKit
import PromiseKit
import Alamofire

class AdminProvider: NSObject {

    func getMyInformation() -> Promise<AMO_MyInformation> {
        let params: Parameters = [:]
        let worker = AdminWorker.init(type: .getMyInformation(params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_MyInformation>) in
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
