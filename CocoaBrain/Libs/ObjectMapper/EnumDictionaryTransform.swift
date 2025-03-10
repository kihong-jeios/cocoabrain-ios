//
//  EnumDictionaryTransform.swift
//  CocoaBrain
//
//  Created by Kai on 3/3/25.
//

import UIKit

class EnumDictionaryTransform<Key: RawRepresentable & Hashable, Value: RawRepresentable>: TransformType where Key.RawValue == String, Value.RawValue == String {

    typealias Object = [Key: Value]
    typealias JSON = [String: String]

    func transformFromJSON(_ value: Any?) -> [Key: Value]? {
        guard let dict = value as? [String: String] else { return nil }
        var result: [Key: Value] = [:]

        for (keyString, valueString) in dict {
            if let key = Key(rawValue: keyString), let value = Value(rawValue: valueString) {
                result[key] = value
            }
        }
        return result
    }

    func transformToJSON(_ value: [Key: Value]?) -> [String: String]? {
        guard let dict = value else { return nil }
        var result: [String: String] = [:]

        for (key, value) in dict {
            result[key.rawValue] = value.rawValue
        }
        return result
    }
}
