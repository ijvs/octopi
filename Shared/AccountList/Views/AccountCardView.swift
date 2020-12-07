//
//  AccountCardView.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import SwiftUI

struct AccountCellViewModel: Identifiable {
    let account: Account
    
    var isEditing: Bool

    var id: String {
        return account.id ?? ""
    }
    
    var issuer: String {
        return account.issuer.capitalized
    }
    var label: String {
        return account.label
    }
    
    var icon: Image? {
        return IconService.getIcon(for: account.issuer)
    }
        
    init(account: Account, isEditing: Bool = false) {
        self.account = account
        self.isEditing = isEditing
    }
}

struct AccountCardView: View {
    
    var model: AccountCellViewModel
    var deleteAction: () -> Void
    
    var body: some View {
        GeometryReader { reader in
            ZStack() {
                HStack {
                    VStack(alignment: .center, spacing: Layout.verticalSpacing) {
                        Text(model.label)
                            .font(.body)
                            .foregroundColor(Theme.Colors.label)
                        HStack {
                            model.icon
                                .frame(width: Layout.iconSide,
                                       height: Layout.iconSide,
                                       alignment: .center)
                                .background(Color.gray)
                            Text(model.issuer)
                                .font(.body)
                                .foregroundColor(Theme.Colors.label)
                        }
                    }
                    .padding(Layout.padding)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Theme.Colors.secondaryBackground)
                    .card()
                }

                if model.isEditing {
                    makeDeleteButton(frame: reader.frame(in: .local))
                }
            }
        }
        .padding()
        .frame(minWidth: Layout.minWidth,
               minHeight: Layout.minHeight)
    }
    
    func makeDeleteButton(frame: CGRect) -> some View {
        Button(action: {
            deleteAction()
        }, label: {
            Layout.deleteIcon
                .resizable()
                .accentColor(Theme.Colors.tint)
                .frame(width: Layout.iconSide,
                       height: Layout.iconSide)
                .padding()
        }).position(x: frame.maxX,
                    y: frame.minY)
    }
    
    struct Layout {
        static let verticalSpacing: CGFloat = 8
        static let minWidth: CGFloat = 130
        static let minHeight: CGFloat = 100
        static let padding: CGFloat = 15

        static let iconSide: CGFloat = 20
        
        static let deleteIcon: Image = Image(systemName: "xmark.circle.fill")
    }
}

struct AccountCardView_Previews: PreviewProvider {
    static var previews: some View {
        let model = AccountCellViewModel(account: Account(digits: 6,
                                                          issuer: "issuer",
                                                          label: "Label",
                                                          period: 30,
                                                          algorithm: .sha1),
                                         isEditing: true)
        return Group {
            AccountCardView(model: model,
                            deleteAction: { })
                .previewLayout(.fixed(width: 150.0, height: 120))
            AccountCardView(model: model,
                            deleteAction: { })
                .previewLayout(.fixed(width: 150.0, height: 120))
                .preferredColorScheme(.dark)
        }
    }
}
