//
//  UserWorker.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

class UserWorker: NSObject {
    var endpoint: UserEndPoints
    init(type: UserEndPoints) {
        switch type {
        case .getUser(userId: _, params: let params):
            self.endpoint = UserEndPoints.getUsers(params: params)
        case .updateUser(userId: let userId, params: let params):
            self.endpoint = UserEndPoints.updateUser(userId: userId, params: params)
        case .getUsers(params: let params):
            self.endpoint = UserEndPoints.getUsers(params: params)
        case .postUser(params: let params):
            self.endpoint = UserEndPoints.postUser(params: params)
        case .patchUser(userId: let userId, params: let params):
            self.endpoint = UserEndPoints.patchUser(userId: userId, params: params)
        case .getMembers(params: let params):
            self.endpoint = UserEndPoints.getMembers(params: params)
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
