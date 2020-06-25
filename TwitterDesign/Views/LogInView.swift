//
//  LogInView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/22/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct LogInView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Image("twitter-logo")
                .resizable()
                .frame(width: 50, height: 50)
            Text("Log in to Twitter")
                .font(Font.system(size: 24, weight: .bold))
                .padding(.vertical, 16)
            
            TextField("Email", text: $email)
                .frame(height: 40)
                .padding(.horizontal, 32)
                .textContentType(.emailAddress)
            Divider()
                .padding(.horizontal, 32)
            
            SecureField("Password", text: $password)
                .frame(height: 40)
                .padding(.horizontal, 32)
            Divider()
                .padding(.horizontal, 32)
            
            Button(action: {
                Auth.auth().signIn(withEmail: self.email, password: self.password) { authResult, error in
                    if let errors = error {
                        print(errors)
                        return
                    }
                    
                    if let strongSelf = authResult {
                        print(strongSelf)
                    }
                  // ...
                }
            }) {
                Text("Log in")
                    .frame(width: 200, height: 44)
                    .background(Color.twitterBlue)
                    .cornerRadius(22)
                    .font(Font.system(size: 16, weight: .bold))
                    .foregroundColor(Color.white)
            }
            
            Spacer()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}
