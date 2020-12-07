//
//  CircleCounterView.swift
//  octopi
//
//  Created by Jony Money on 12/6/20.
//

import SwiftUI

struct CircleCounterView: View {
    
    var total: Double
    var lineWidth: CGFloat = 5
    
    var label: String
    var remaining: Double = 0
    
    var body: some View {
        GeometryReader { reader in
            ZStack {
                makeCircle(frame: reader.frame(in: .local),
                           startAngle: Constants.startAngle,
                           endAngle: Constants.endAngle,
                           clockwise: true)
                    .stroke(Theme.Colors.ternaryLabel,
                            lineWidth: lineWidth)
                makeCircle(frame: reader.frame(in: .local),
                           startAngle: calculateStartAngle(remaining: remaining,
                                                           total: total),
                           endAngle: Constants.endAngleB,
                           clockwise: false)
                    .stroke(Theme.Colors.tint,
                            lineWidth: lineWidth)
                Text(label)
                    .foregroundColor(Theme.Colors.label)
            }
        }
    }
    
    func makeCircle(frame: CGRect,
                    startAngle: Double,
                    endAngle: Double,
                    clockwise: Bool) -> Path {
        return Path { path in
            path.addArc(center: CGPoint(x: frame.midX, y: frame.midY),
                        radius: frame.width / 2,
                        startAngle: Angle(degrees: startAngle),
                        endAngle: Angle(degrees: endAngle),
                        clockwise: clockwise)
        }
    }
    
    func calculateStartAngle(remaining: Double,
                             total: Double) -> Double {
        guard remaining != total else {
            return Constants.fakeStartAngleB
        }
        let percentage: Double = ((total - remaining) * 100) / total
        let initial: Double = Constants.startAngleB
        let newAngle = initial + (Constants.angleStep * percentage)
        return newAngle
    }
    
    struct Constants {
        static let startAngle: Double = 0
        static let endAngle: Double = 360
        
        static let endAngleB: Double = -90
        static let startAngleB: Double = -90
        static let fakeStartAngleB: Double = -89.99
        static let angleStep: Double = 3.6
    }
}

struct CircleCounterView_Previews: PreviewProvider {

    static var previews: some View {
        CircleCounterView(total: 30, label: "30", remaining: 30)
            .previewLayout(.fixed(width: 30.0, height: /*@START_MENU_TOKEN@*/30.0/*@END_MENU_TOKEN@*/))
    }
}
