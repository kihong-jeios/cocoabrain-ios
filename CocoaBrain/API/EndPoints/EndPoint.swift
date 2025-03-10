//
//  EndPoint.swift
//  CocoaBrain
//
//  Created by Kai on 2/24/25.
//

import UIKit
import Alamofire

enum EndpointURI: String {
    case dev = "http://121.169.251.9:2000/coghealthtest"
    case prod = "https://cocoabrain.net/coghealthtest"
}

protocol Endpoint {
    var baseURL: String { get } // https://example.com/
    var path: String { get } // users/
    var fullURL: String { get } // https://example.com/users/
    var method: HTTPMethod { get } // .get
    var encoding: ParameterEncoding { get } // URLEncoding.default
    var body: Parameters { get } // ["foo" : "bar"]
    var headers: HTTPHeaders { get } // ["Authorization" : "Bearer SOME_TOKEN"]
}

extension Endpoint {
    
    var baseURL: String {
        return EndpointURI.dev.rawValue
    }
    
    var encoding: ParameterEncoding {
        return method == .get ? URLEncoding.default : JSONEncoding.default
    }
    
    var fullURL: String {
        return baseURL + path
    }
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        if let token = UDManager.SI.getAccessToken() {
            headers.add(name: "Authorization", value: "Bearer "+token)
        }
        headers.add(name: "Content-Type", value: "application/json")
        headers.add(name: "X-Platform", value: "iOS")
        headers.add(name: "version", value: PrefsManager.SI.getAppVersion())
        let lang = NSLocale.current.language.languageCode?.identifier ?? "en"
        headers.add(name: "language", value: lang)
        return headers
    }

}
