//
//  Theme.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import Foundation
import SwiftUI

struct Theme {
    
    struct Colors {
        static let background: Color = Color("Background")
        static let secondaryBackground: Color = Color("SecondaryBackground")
        static let ternaryBackground: Color = Color("TernaryBackground")
        static let buttonBackground: Color = Color("ButtonBackground")
        static let label: Color = Color("Label")
        static let secondaryLabel: Color = Color("SecondaryLabel")
        static let ternaryLabel: Color = Color("TernaryLabel")
        static let buttonLabel: Color = Color("ButtonLabel")
        static let tint: Color = Color("Tint")
        
        static let shadow: Color = Color.black.opacity(0.05)
    }
    
    struct Layout {
        static let cornerRadius: CGFloat = 8
        static let shadowRadius: CGFloat = 8
        static let shadowOffset: CGPoint = CGPoint(x: 0, y: 4)
    }
}
