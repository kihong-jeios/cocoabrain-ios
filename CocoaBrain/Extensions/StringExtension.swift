//
//  StringExtension.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

extension String {
    var lo: String {
        get {
            let localizedString  = NSLocalizedString(self, comment: "")
            return localizedString
        }
    }
    
}
