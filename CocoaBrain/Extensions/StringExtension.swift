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
    
    func convertDateFormat() -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyyMMdd"
//        inputFormatter.locale = Locale(identifier: "ko_KR")
        
        guard let date = inputFormatter.date(from: self) else { return nil }
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        
        return outputFormatter.string(from: date)
    }

}
