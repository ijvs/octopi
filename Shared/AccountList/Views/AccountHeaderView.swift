//
//  AccountHeaderView.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import SwiftUI

class HeaderOTPViewModel: ObservableObject {
    var issuer: String {
        return account.issuer.capitalized
    }
    var label: String {
        return account.label
    }
    
    var icon: Image? {
        return nil
    }
    
    var period: Double {
        return Double(account.period)
    }
    
    @Published var otp: String = "--- ---"
    @Published var remainingSeconds: Int = 0

    private let account: Account
    private var otpService: OTPService?
    private var timer: Timer?
    private let feedbackGenerator = UIImpactFeedbackGenerator()

    init(account: Account) {
        self.account = account
        otpService = OTPService(account: account)
        start()
    }
    
    private func start() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateOTP),
                                     userInfo: nil,
                                     repeats: true)
        timer?.fire()
    }

    @objc func updateOTP() {
        guard let generated = otpService?.generate() else { return }

        withAnimation {
            otp = generated.otp ?? "--- ---"
            remainingSeconds = generated.remainingSeconds
        }
    }

    func copyOTP() {
        UIPasteboard.general.string = otp
        NotificationCenter.default.post(name: .DidCopyOTP, object: nil)
        feedbackGenerator.impactOccurred()
    }
}

struct AccountHeaderView: View {
    
    @ObservedObject var model: HeaderOTPViewModel


    var body: some View {
        ZStack {
            VStack(spacing: Layout.spacing) {
                Spacer()
                HStack(spacing: Layout.spacing) {
                    if let icon = model.icon {
                        icon
                            .frame(width: Layout.iconSide,
                                   height: Layout.iconSide)
                            .background(Color.gray)
                    }
                    Text(model.issuer)
                        .font(.largeTitle)
                    CircleCounterView(total: model.period,
                                      lineWidth: 3,
                                      label: "\(model.remainingSeconds)",
                                      remaining: Double(model.remainingSeconds))
                        .frame(width: Layout.counterSide,
                               height: Layout.counterSide)
                }
                HStack {
                    Text(model.otp)
                        .colorMultiply(Theme
                                        .Colors.label)
                        .font(.largeTitle)
                }
                Text(model.label)
                    .font(.body)
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    copyButton.padding()
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: Layout.height)
        .background(Theme.Colors.background)

    }
    
    var copyButton: some View {
        Button(action: {
            model.copyOTP()
        }, label: {
            Layout.copyIcon
                .resizable()
                .scaledToFit()
                .accentColor(Theme.Colors.tint)
                .frame(width: Layout.iconSide,
                       height: Layout.iconSide)
        })
    }
    
    
    struct Layout {
        static let height: CGFloat = 200
        static let spacing: CGFloat = 10
        static let iconSide: CGFloat = 30
        static let counterSide: CGFloat = 30
        
        static let copyIcon: Image = Image(systemName: "doc.on.doc")
    }
}

struct AccountHeaderView_Previews: PreviewProvider {
    
    static let account = Account(digits: 6,
                                 issuer: "issuer",
                                 label: "Label",
                                 period: 30,
                                 algorithm: .sha1)
    @State static var state: HeaderOTPViewModel = HeaderOTPViewModel(account: account)
    
    static var previews: some View {
        Group {
            AccountHeaderView(model: state)
                .previewLayout(.fixed(width: 300, height: 200.0))
            AccountHeaderView(model: state)
                .preferredColorScheme(.dark)
                .previewLayout(.fixed(width: 300, height: 200.0))
        }
    }
}
