//
//  ReqResProvider.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Moya

/** MoyaProvider: This file contains the MoyaProvider definition.  All endpoints, parameters, headers, etc. are set here.
    NOTE: See `NetworkServiceType` for the protocol that makes use of this Provider.
**/

// MARK: - Provider setup.  This is a JSON formatting plugin
func JSONResponseDataFormatter(_ data: Data) -> Data {
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

// MARK: Token Authentication Endpoint
/** This is an example of a custom endpoint in Moya.  While this might look a bit complicated
    at first glance, it just specifies which endpoints shouold have the token that is stored in
    the Keychain as part of the request.
 
    NOTE: the .color endpoint is not ACTUALLY a secure endpoint.  This is just for example purposes.
**/
fileprivate let endpointClosure = { (target: APIName) -> Endpoint<APIName> in
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    let endpoint: Endpoint<APIName> = Endpoint<APIName>(URL: url,
                                                  sampleResponseClosure: {.networkResponse(200, target.sampleData)},
                                                  method: target.method, parameters: target.parameters)
    
    switch target {
    case .colors, .register(_, _):
        return endpoint
    case .color(_):
        return endpoint.adding(httpHeaderFields: ["x-access-token": AppStorage.token!])
    }
}

// The enum that contains our endpoint definitions.
enum APIName {
    case colors
    case color(id: String)
    case register(email: String, password: String)
}

// The enum conforms to `TargetType`
extension APIName: TargetType {
    var baseURL: URL { return URL(string: "http://reqres.in/ap")! }
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
    
    // The method
    var method: Moya.Method {
        switch self {
        case .colors, .color(_):
            return .get
        case .register(_, _):
            return .post
        }
    }
    
    // The parameters
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
    
    // The type of Task (there are several)
    var task: Task {
        return .request
    }
    
    // Here we provide sample data for testing
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

// Convenience function
public func url(_ route: TargetType) -> String {
    return route.baseURL.appendingPathComponent(route.path).absoluteString
}

