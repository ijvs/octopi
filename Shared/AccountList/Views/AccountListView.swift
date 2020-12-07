//
//  AccountListView.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import SwiftUI

struct AccountListView: View {
    var body: some View {
        AccountHeaderView(model: HeaderOTPViewModel(account: Account(digits: 6,
                                                                     issuer: "issuer",
                                                                     label: "Label",
                                                                     period: 30,
                                                                     algorithm: .sha1)))
    }
}

struct AccountListView_Previews: PreviewProvider {
    static var previews: some View {
        AccountListView()
    }
}
