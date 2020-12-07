//
//  OTPService.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import Foundation
import SwiftOTP
import SwiftKeychainWrapper

class OTPService {
    private let totp: TOTP
    private let period: Int
    
    init?(account: Account) {
        guard let secret = OTPService.getSecret(account: account),
              let secretBase32 = base32Decode(secret),
              let totp = TOTP(secret: Data(secretBase32),
                              digits: account.digits,
                              timeInterval: account.period,
                              algorithm: account.algorithm.totp) else {
            return nil
        }
        self.totp = totp
        self.period = account.period
    }
    
    private static func getSecret(account: Account) -> String? {
        guard let id = account.id else {
            return nil
        }
        return KeychainWrapper.standard.string(forKey: id)
    }
    
    func generate() -> (remainingSeconds: Int, otp: String?)? {
        let time = Int(Date().timeIntervalSince1970)
        let currentPeriod = time%period
        let value = totp.generate(secondsPast1970: time)
        return (period - currentPeriod, value)
    }
}
