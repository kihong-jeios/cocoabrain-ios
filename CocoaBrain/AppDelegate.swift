//
//  AppDelegate.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var loginVC: LoginVC?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UDManager.SI.setFirstLaunch()
        
        if UDManager.SI.isFirstLaunch == true {
            UDManager.SI.setIsEnabledAutoLogin(true)
            UDManager.SI.setIsEnabledIdSave(false)
        }
        
        let font = UIFont.textStyleHeading()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.brainTertiary
        ]
        UINavigationBar.appearance().tintColor = .brainTertiary
        UINavigationBar.appearance().backgroundColor = .brainBackground
        UINavigationBar.appearance().titleTextAttributes = attributes
        
        loginVC = LoginVC()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.overrideUserInterfaceStyle = .light
        self.window!.rootViewController = loginVC!
        self.window!.makeKeyAndVisible()
        
        return true
    }


}

