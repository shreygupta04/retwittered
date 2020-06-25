//
//  OnboardView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/22/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct OnboardView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image("twitter-logo")
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("See what's\nhappening in the\nworld right now.")
                    .frame(maxWidth: .infinity, maxHeight: 110, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(32)
                    .font(Font.system(size: 28, weight: .bold))
                HStack(spacing: 16) {
                    NavigationLink(destination: LogInView()) {
                        Text("Log In")
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .overlay(RoundedRectangle(cornerRadius: 22).stroke(Color.twitterBlue, lineWidth: 2))
                        .foregroundColor(Color.twitterBlue)
                        .font(Font.system(size: 16, weight: .bold))
                        
                    }
                    
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                        .frame(maxWidth: .infinity, maxHeight: 44)
                        .background(Color.twitterBlue)
                        .cornerRadius(22)
                        .foregroundColor(Color.white)
                        .font(Font.system(size: 16, weight: .bold))
                        
                    }
                }
                .padding(32)
            }
        }
    }
}

struct OnboardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardView()
    }
}
