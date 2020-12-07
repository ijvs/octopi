//
//  Algorithm.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import Foundation
import SwiftOTP

enum Algorithm: String, Codable {
    case sha1 = "SHA1"
    case sha256 = "SHA256"
    case sha512 = "SHA512"
    
    var totp: OTPAlgorithm {
        switch self {
        case .sha1:
            return .sha1
        case .sha256:
            return .sha256
        case .sha512:
            return .sha512
        }
    }
}
