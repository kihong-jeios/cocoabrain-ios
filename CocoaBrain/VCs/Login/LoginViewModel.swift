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
    func presentMainVC()
}

class LoginViewModel: NSObject {
    
    weak open var delegate: LoginViewModelDelegate?
    let loginProvider = LoginProvider()
    let adminProvider = AdminProvider()
    
    var selectedCenterId: Double?
    var centers: [AMO_CenterList] = []
    
    func prepare() {
        checkAutoLogin()
        
        loginProvider.getCenterList().done { center in
            self.centers = center.data.list
            self.delegate?.didUpdateCenters(center.data.list)
            
        }.catch { error in
            
        }
    }
    
    func login(id: String, password: String) {
        loginProvider.login(centerId: selectedCenterId ?? 0, email: id, password: password).done { data in
            UDManager.SI.setAccessToken(data.data.token.accessToken)
            UDManager.SI.setRefreshToken(data.data.token.refreshToken)
            print("accessToken : \(data.data.token.accessToken)")
            self.delegate?.presentMainVC()
            PrefsManager.SI.centerName = data.data.admin.centerName
            PrefsManager.SI.userName = data.data.admin.name
            
        }.catch { error in
            
        }
    }
    
    func checkAutoLogin() {
        if let refreshToken = UDManager.SI.getRefreshToken(),
            UDManager.SI.getIsEnabledAutoLogin() == true {
            loginProvider.refresh(refreshToken: refreshToken).done { refreshData in
                UDManager.SI.setAccessToken(refreshData.data.accessToken)
                UDManager.SI.setRefreshToken(refreshData.data.refreshToken)
                print("accessToken : \(refreshData.data.accessToken)")
                self.delegate?.presentMainVC()
                self.getMyInformation()
                
            }.catch { error in
                
            }
        }
    }
    
    func getMyInformation() {
        adminProvider.getMyInformation().done { data in
            PrefsManager.SI.centerName = data.data.centerName
            PrefsManager.SI.userName = data.data.name
        }.catch { error in
            
        }
    }
    
}
