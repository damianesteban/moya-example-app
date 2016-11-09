//
//  DomainError.swift
//  Example
//
//  Created by Damian Esteban on 05/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

//enum DomainError: Error {
//    case jsonError
//}

struct DomainError: Swift.Error {
    public let file: StaticString
    public let function: StaticString
    public let line: UInt
    public let message: String
    
    public init(message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.file = file
        self.function = function
        self.line = line
        self.message = message
    }
    
    static func underlyingError(error: Swift.Error) {
        print(error)
    }
}
