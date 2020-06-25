//
//  TabBar.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/17/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack {
            Button(action: {
                self.currentIndex = 0
            }) {
                Image(systemName: "house")
                    .foregroundColor(self.currentIndex == 0 ? Color.twitterBlue : Color.gray)
                    .animation(Animation.default)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: {
                self.currentIndex = 1
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(self.currentIndex == 1 ? Color.twitterBlue : Color.gray)
                    .animation(Animation.default)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: {
                self.currentIndex = 2
            }) {
                Image(systemName: "person")
                    .foregroundColor(self.currentIndex == 2 ? Color.twitterBlue : Color.gray)
                    .animation(Animation.default)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: {
                self.currentIndex = 3
            }) {
                Image(systemName: "bell")
                    .foregroundColor(self.currentIndex == 3 ? Color.twitterBlue : Color.gray)
                    .animation(Animation.default)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            Button(action: {
                self.currentIndex = 4
            }) {
                Image(systemName: "envelope")
                    .foregroundColor(self.currentIndex == 4 ? Color.twitterBlue : Color.gray)
                    .animation(Animation.default)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(height: 50)
        .font(Font.system(size: 20, weight: .semibold))
    }
}
