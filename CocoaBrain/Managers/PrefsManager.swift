//
//  PrefsManager.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

enum BuildType {
    case DEV
    case PRD
}

class PrefsManager: NSObject {
    
    static let SI = PrefsManager()
    
    override init() {
        super.init()
    }
    
    var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    var centerName: String = ""
    var userName: String = ""
    
    func getAppVersion() -> String { //2.0.4의 형태로 내려줌
        guard let dictionary = Bundle.main.infoDictionary,
            let version = dictionary["CFBundleShortVersionString"] as? String
            else { return "" }
        
        return version
    }
    
    func getIntegerAppVersion() -> Int { //2.0.4 -> 204의 형태로 내려줌
        guard let dictionary = Bundle.main.infoDictionary,
            var version = dictionary["CFBundleShortVersionString"] as? String
            else { return 0 }
        
        if version.contains("d") {
            if let tempVersion = version.split(separator: "-").first {
                version = String(tempVersion)
            }
        }
        guard let integerVersion = Int.parse(from: version)
            else { return 0 }
        return integerVersion
    }
    
    

}
