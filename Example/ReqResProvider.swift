//
//  ReqResProvider.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider setup
private func JSONResponseDataFormatter(_ data: Data) -> Data {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return prettyData
    } catch {
        return data //fallback to original data if it cant be serialized
    }
}

let APIProvider = MoyaProvider<APIName>(plugins: [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])

// MARK: - Provider support
private extension String {
    var urlEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

enum APIName {
    case colors
    case color(id: String)
    case register(email: String, password: String)
}

extension APIName: TargetType {
    var baseURL: URL { return URL(string: "http://reqres.in/api")! }
    var path: String {
        switch self {
        case .colors:
            return "/colors"
        case .color(let id):
            return "/users/\(id)"
        case .register:
            return "/register"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .colors, .color(_):
            return .GET
        case .register(_, _):
            return .POST
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .colors:
            return nil
        case .color(_):
            return nil
        case .register(let id, let password):
            return [
                "email": id,
                "password": password
            ]
        }
    }
        
    var task: Task {
        return .request
    }
        
    var sampleData: Data {
        switch self {
        case .color:
            return "Half measures are as bad as nothing at all.".data(using: String.Encoding.utf8)!
        case .colors(_):
            return "sdsdsd}".data(using: String.Encoding.utf8)!
        case .register(_, _):
            return "[{\"name\": \"Repo Name\"}]".data(using: String.Encoding.utf8)!
        }
    }
}

public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

