//
//  AccountHeaderEmptyView.swift
//  octopi
//
//  Created by Jony Money on 12/7/20.
//

import SwiftUI

struct AccountHeaderEmptyView: View {
    var body: some View {
        VStack(spacing: Layout.spacing) {
            Text(Layout.description)
                .font(.title2)
                .accentColor(Theme.Colors.label)
                .multilineTextAlignment(.center)
                .frame(maxWidth: Layout.maxWidth)
        }
        .frame(maxWidth: .infinity)
        .frame(height: Layout.height)
        .background(Layout.backgroundColor)
    }
    
    struct Layout {
        static let height: CGFloat = 200
        static let maxWidth: CGFloat = 300

        static let spacing: CGFloat = 20
        static let padding: CGFloat = 40
        
        static let description: String = "Aun no tienes ninguna cuenta agregada."
        static let backgroundColor: Color = Color("SecondaryBackground")
    }
}

struct AccountHeaderEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        AccountHeaderEmptyView()
    }
}
