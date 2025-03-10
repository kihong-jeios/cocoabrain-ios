//
//  UDManager.swift
//  CocoaBrain
//
//  Created by Kai on 2/27/25.
//

import UIKit

class UDManager: NSObject {
    
    static let SI = UDManager()
    override init() {
        super.init()
    }
    
    var isFirstLaunch: Bool = false
    func setFirstLaunch() {
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            UserDefaults.standard.synchronize()
            isFirstLaunch = true
        }
    }

    func getIsEnabledAutoLogin() -> Bool {
        let isEnabledAutoLogin = UserDefaults.standard.bool(forKey: "isEnabledAutoLogin")
        return isEnabledAutoLogin
    }
    
    func setIsEnabledAutoLogin(_ isEnabledAutoLogin: Bool) {
        UserDefaults.standard.set(isEnabledAutoLogin, forKey: "isEnabledAutoLogin")
        UserDefaults.standard.synchronize()
    }
    
    
    
    func getIsEnabledIdSave() -> Bool {
        let isEnabledIdSave = UserDefaults.standard.bool(forKey: "isEnabledIdSave")
        return isEnabledIdSave
    }
    
    func setIsEnabledIdSave(_ isEnabledIdSave: Bool) {
        UserDefaults.standard.set(isEnabledIdSave, forKey: "isEnabledIdSave")
        UserDefaults.standard.synchronize()
    }
    
    
    
    func getAccessToken() -> String? {
        let accessToken = UserDefaults.standard.string(forKey: "accessToken")
        return accessToken
    }
    
    func setAccessToken(_ accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: "accessToken")
        UserDefaults.standard.synchronize()
    }
    
    
    
    func getRefreshToken() -> String? {
        let accessToken = UserDefaults.standard.string(forKey: "refreshToken")
        return accessToken
    }
    
    func setRefreshToken(_ refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    
    func removeTokens() {
        UserDefaults.standard.removeObject(forKey: "accessToken")
        UserDefaults.standard.removeObject(forKey: "refreshToken")
        UserDefaults.standard.synchronize()
    }
}
