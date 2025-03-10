//
//  TmtViewModel.swift
//  CocoaBrain
//
//  Created by Kai on 3/9/25.
//

import UIKit

protocol TmtViewModelDelegate: AnyObject {
    func didUpdateCircles()
}

struct Circle: Codable {
    let isWhite: Bool
    let number: Int
    let x: Double
    let y: Double
}

class TmtViewModel: NSObject {
    
    weak open var delegate: TmtViewModelDelegate?

    var circles: [Circle] = []
    
    func prepare(type: TmtIntroType) {
        guard let jsonString = loadJsonString(from: "circles") else { return }
        let json = JSON(parseJSON: jsonString)
        var theCircles: [JSON] = []
        switch type {
        case .typeA:
            theCircles = json["2024-10-14-130650"]["circles"].arrayValue
        case .typeB:
            theCircles = json["2024-10-21-171711"]["circles"].arrayValue
        }
        
        for c in theCircles {
            let isWhite = c["isWhite"].boolValue
            let number = c["number"].intValue
            let x = c["x"].doubleValue
            let y = c["y"].doubleValue
            let theCircle: Circle = Circle(isWhite: isWhite, number: number, x: x, y: y)
            self.circles.append(theCircle)
        }
        delegate?.didUpdateCircles()
    }
    
    func loadJsonString(from fileName: String) -> String? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        do {
            let jsonString = try String(contentsOfFile: path, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
}
