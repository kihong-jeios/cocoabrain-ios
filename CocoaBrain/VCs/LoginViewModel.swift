//
//  LoginViewModel.swift
//  CocoaBrain
//
//  Created by Kai on 2/26/25.
//

import UIKit
import Alamofire
import PromiseKit

protocol LoginViewModelDelegate: AnyObject {
    func didUpdateCenters(_ centers: [AMO_CenterList])
}

class LoginViewModel: NSObject {
    
    weak open var delegate: LoginViewModelDelegate?
    let loginProvider = LoginProvider()
    
    var selectedCenterId: Double?
    
    func prepare() {
        loginProvider.getCenterList().done { center in
            self.delegate?.didUpdateCenters(center.data.list)
            
        }.catch { error in
            
        }
    }
    
    func login(id: String, password: String) {
        loginProvider.login(centerId: selectedCenterId ?? 0, email: id, password: password).done { data in
            print(data.data.token.accessToken)
            
        }.catch { error in
            
        }
    }
    
    

}
