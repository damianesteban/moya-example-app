//
//  Constants.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

struct Constants {
    static let KeychainService = "com.damianesteban.example.userauthtoken"
    static let UserTokenKey = "userToken"
}

// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

#if os(iOS) || os(tvOS) || os(watchOS)
    import UIKit.UIColor
    typealias Color = UIColor
#elseif os(OSX)
    import AppKit.NSColor
    typealias Color = NSColor
#endif

extension Color {
    convenience init(rgbaValue: UInt32) {
        let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
        let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
        let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
        let alpha = CGFloat((rgbaValue      ) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length
enum ColorName {
    /// <span style="display:block;width:3em;height:2em;border:1px solid black;background:#4152af"></span>
    /// Alpha: 100% <br/> (0x4152afff)
    case Indigo
    
    var rgbaValue: UInt32 {
        switch self {
        case .Indigo: return 0x4152afff
        }
    }
    
    var color: Color {
        return Color(named: self)
    }
}
// swiftlint:enable type_body_length

extension Color {
    convenience init(named name: ColorName) {
        self.init(rgbaValue: name.rgbaValue)
    }
}
