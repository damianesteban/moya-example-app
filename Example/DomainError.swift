//
//  DomainError.swift
//  Example
//
//  Created by Damian Esteban on 05/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Moya


struct DomainError: Swift.Error {
    public let file: StaticString
    public let function: StaticString
    public let line: UInt
    public let message: String
    public let underlyingError: Swift.Error?
    public let moyaError: Moya.Error?
    
    public init(message: String, file: StaticString = #file, function: StaticString = #function,
        line: UInt = #line, underlyingError: Swift.Error? = nil, moyaError: Moya.Error? = nil) {
        self.file = file
        self.function = function
        self.line = line
        self.message = message
        self.underlyingError = underlyingError
        self.moyaError = moyaError
    }
}
