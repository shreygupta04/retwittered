//
//  PercentCircle.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/24/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI

struct PercentCircle: Shape {
    
    @Binding var text: String
    
    func path(in rect: CGRect) -> Path {
        let percentFilled = Double(text.count)/280.0
        let width = rect.width
        let height = rect.height
        
        let center = CGPoint(x: width/2, y: height/2)
        let endAngle = Angle(degrees: percentFilled * 360.0 - 90)
        
        let radius = width/2
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: endAngle, endAngle: Angle(degrees: -90), clockwise: true)
        
        return path
    }
    
    
}
