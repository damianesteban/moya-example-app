//
//  APINameService.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Moya
import Result

struct APINameService: NetworkServiceType {
    
    var provider: MoyaProvider<APIName>
    
    init(provider: MoyaProvider<APIName> = MoyaProvider<APIName>(plugins:
        [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])) {
        self.provider = provider
    }
    
    func getColors(target: APIName, completion: @escaping (Result<[Color], DomainError>) -> Void) {
        return self.requestObjects(target: target, completion: completion)
    }
}

