//
//  IntExtension.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit

extension Int
{
    func toString() -> String
    {
        let myString = String(self)
        return myString
    }
    
    static func parse(from string: String) -> Int? {
        return Int(string.components(separatedBy: CharacterSet.decimalDigits.inverted).joined())
    }
    
    func toStringMin() -> String {
        let time = NSInteger(self)
        
        let minutes = (time / 60)
        return String(format: "%d", minutes)
    }
    
    func toStringMinSec() -> String {
        let time = NSInteger(self)

        let seconds = time % 60
        let minutes = (time / 60) % 60

        return String(format: "%0.2d:%0.2d%", minutes, seconds)
    }
    
    func toStringHourMinSec() -> String {
        let time = NSInteger(self)

        let hours = time / 3600
        let seconds = time % 60
        let minutes = (time / 60) % 60
        
        var timeString = ""
        if hours > 0 {
            timeString = String(format: "%d:%02d:%02d", hours, minutes, seconds)
        } else {
            timeString = String(format: "%02d:%02d", minutes, seconds)
        }
        return timeString
    }
}
