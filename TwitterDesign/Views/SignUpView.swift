//
//  SignUpView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/22/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
            Image("twitter-logo")
                .resizable()
                .frame(width: 50, height: 50)
            Text("Create your account")
                .font(Font.system(size: 24, weight: .bold))
                .padding(.vertical, 16)
            TextField("Name", text: $name)
                .frame(height: 40)
                .padding(.horizontal, 32)
            Divider()
                .padding(.horizontal, 32)
            
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
                // all fields should be filled out
                Auth.auth().createUser(withEmail: self.email, password: self.password) { (result, error) in
                    if let authError = error {
                        print("Error when signing up \(authError)")
                        return
                    }
                    if let authResult = result {
                        let request = authResult.user.createProfileChangeRequest()
                        request.displayName = self.name
                        request.commitChanges { (error2) in
                            if let requestError = error2 {
                                print("Error while updating name \(requestError)")
                            }
                            
                            let reference = Database.database().reference().child("users").child(authResult.user.uid)
                            reference.setValue(self.name) { (error3, ref) in
                                if let databaseError = error3 {
                                    print("Error when adding user to database \(databaseError)")
                                }
                                
                            }
                        }
                    }
                }
            }) {
                Text("Sign up")
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

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
