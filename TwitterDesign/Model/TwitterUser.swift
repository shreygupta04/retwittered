//
//  TwitterUser.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/23/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import Foundation

struct TwitterUser: Identifiable, Equatable {
    var name: String
    var uid: String
    
    var id: String {
        return uid
    }
}
