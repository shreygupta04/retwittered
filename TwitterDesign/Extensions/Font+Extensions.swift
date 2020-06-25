//
//  Font+Extensions.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/17/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI

extension Font {
    static func montserratFont(size: CGFloat, isBold: Bool = false) -> Font {
        return isBold ? Font.custom("Montserrat-Bold", size: size) : Font.custom("Montserrat-Regular", size: size)
//        if isBold {
//            return Font.custom("Montserrat-Bold", size: size)
//        }
//        else {
//            return Font.custom("Montserrat-Regular", size: size)
//        }
    }
}
