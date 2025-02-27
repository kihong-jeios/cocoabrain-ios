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
        
        loginVC = LoginVC()
        let loginNavi = UINavigationController(rootViewController: loginVC!)
        loginNavi.modalPresentationStyle = .fullScreen
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window!.overrideUserInterfaceStyle = .light
        self.window!.rootViewController = loginNavi
        self.window!.makeKeyAndVisible()
        
        return true
    }


}

