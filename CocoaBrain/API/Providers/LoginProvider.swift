//
//  LoginProvider.swift
//  CocoaBrain
//
//  Created by Kai on 2/26/25.
//

import UIKit
import PromiseKit
import Alamofire

class LoginProvider: NSObject {
    
    func login(centerId: Double, email: String, password: String) -> Promise<AMO_Login> {
        var params: Parameters = [:]
        params["centerId"] = centerId
        params["email"] = email
        params["password"] = password
        let worker = AdminWorker.init(type: .login(params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_Login>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }
    
    func refresh(refreshToken: String) -> Promise<AMO_Refresh> {
        var params: Parameters = [:]
        params["token"] = refreshToken
        let worker = AdminWorker.init(type: .refresh(params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_Refresh>) in
                switch response.result {
                case .success(let value):
                    seal.fulfill(value)
                    
                case .failure(let error):
                    seal.reject(error)
                }
            }
        }
    }

    func getCenterList() -> Promise<AMO_Center> {
        var params = Parameters()
        params["keyword"] = ""
        params["page"] = 0
        params["size"] = 0
        params["sortDirection"] = "ASC"
        params["sortBy"] = "createdAt"
        let worker = CenterWorker.init(type: .getAllCenters(params: params))
        return Promise { seal in
            worker.request.validate().responseObject { (response: AFDataResponse<AMO_Center>) in
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
