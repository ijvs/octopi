//
//  Account.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import Foundation

struct Account: Codable {
    
    var id: String?
    var digits: Int
    var issuer: String
    var label: String
    var period: Int
    var algorithm: Algorithm
    var secret: String?
        
    init(id: String? = nil, digits: Int, issuer: String, label: String, period: Int, algorithm: Algorithm) {
        self.id = id
        self.digits = digits
        self.issuer = issuer
        self.label = label
        self.period = period
        self.algorithm = algorithm
    }
}
