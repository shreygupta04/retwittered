//
//  UsersView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/23/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct UsersView: View {
    @Binding var allUsers: [TwitterUser]
    @Binding var followingUsers: [TwitterUser]
    
    var logoutButton: some View {
        Button(action: {
            try? Auth.auth().signOut()
        }) {
            Image(systemName: "escape")
                .foregroundColor(Color.twitterBlue)
                .font(Font.system(size: 24))
        }
    }
    
    var body: some View {
        List {
            ForEach(allUsers) { user in
                HStack {
                    Text(user.name)
                        .font(Font.system(size: 16, weight: .bold))
                    Spacer()
                    
                    if Auth.auth().currentUser?.uid == user.uid {
                        Text("You")
                        .frame(width: 120, height: 36)
                        .foregroundColor(Color.gray)
                            .font(Font.system(size: 14, weight: .bold))
                    }
                    
                    else if self.followingUsers.contains(user) {
                        Button(action: {
                            self.unfollow(user)
                        }) {
                            Text("Following")
                                .frame(width: 120, height: 36)
                                .background(Color.twitterBlue)
                                .cornerRadius(18)
                                .foregroundColor(Color.white)
                                .font(Font.system(size: 14, weight: .bold))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    else {
                        Button(action: {
                            self.follow(user: user)
                        }) {
                            Text("Follow")
                                .frame(width: 120, height: 36)
                                .overlay(RoundedRectangle(cornerRadius: 22)
                                .stroke(Color.twitterBlue, lineWidth: 2))
                                .foregroundColor(Color.twitterBlue)
                                .font(Font.system(size: 14, weight: .bold))
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .navigationBarTitle("Users", displayMode: .inline)
    .navigationBarItems(trailing: logoutButton)
    }
    
    func follow(user: TwitterUser) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var reference = Database.database().reference().child("followers").child(currentUser.uid)
        reference = reference.child(user.uid)
        reference.setValue(user.name)
    }
    
    func unfollow(_ user: TwitterUser) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        var reference = Database.database().reference().child("followers").child(currentUser.uid)
        reference = reference.child(user.uid)
        reference.removeValue()
    }
}

//struct UsersView_Previews: PreviewProvider {
//    static var previews: some View {
//        UsersView()
//    }
//}
