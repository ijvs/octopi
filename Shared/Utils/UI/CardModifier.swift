//
//  CardModifier.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import SwiftUI

struct CardView: ViewModifier {
    
    var cornerRadius: CGFloat
    var shadowColor: Color
    var shadowRadius: CGFloat
    var shadowOffset: CGPoint
        
    func body(content: Content) -> some View {
        content
            .cornerRadius(Theme.Layout.cornerRadius)
            .shadow(color: shadowColor,
                    radius: shadowRadius,
                    x: shadowOffset.x,
                    y: shadowOffset.y)
    }
}

extension View {
    func card(cornerRadius: CGFloat = Theme.Layout.cornerRadius,
              shadowColor: Color = Theme.Colors.shadow,
              shadowRadius: CGFloat = Theme.Layout.shadowRadius,
              shadowOffset: CGPoint = Theme.Layout.shadowOffset
              ) -> some View {
        self.modifier(CardView(cornerRadius: cornerRadius,
                               shadowColor: shadowColor,
                               shadowRadius: shadowRadius,
                               shadowOffset: shadowOffset))
    }
}
