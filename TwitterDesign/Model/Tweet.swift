//
//  Tweet.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/25/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import Foundation

struct Tweet: Identifiable {
    var text: String
    var account: TwitterUser
    var postDate: Date
    var likes: [String]
    var id: String
    var displayDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yy"
        return formatter.string(from: postDate)
    }
}
