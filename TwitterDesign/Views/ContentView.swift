//
//  ContentView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/17/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State private var currentIndex = 0
    @State private var allUsers = [TwitterUser]()
    @State private var followingUsers = [TwitterUser]()
    
    @State private var showingTweetView = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ZStack(alignment: .bottomTrailing) {
                    if currentIndex == 0 {
                        HomeView(followingUsers: $followingUsers)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    if currentIndex == 1 {
                        SearchView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    if currentIndex == 2 {
                        UsersView(allUsers: $allUsers, followingUsers: $followingUsers)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    if currentIndex == 3 {
                        NotificationView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    if currentIndex == 4 {
                        MessagesView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Button(action : {
                        self.showingTweetView = true
                    }) {
                        Image("new-tweet")
                            .resizable()
                            .frame(width: 28, height: 28)
                            .padding(16)
                            .background(Color.twitterBlue)
                            .cornerRadius(100)
                            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
                            .padding(16)
                    }
                    NavigationLink(destination: TweetView(isShown: $showingTweetView), isActive: $showingTweetView) {
                        EmptyView()
                    }
                }
                
                Divider()
                    .background(Color.twitterBlue)
                
                TabBar(currentIndex: $currentIndex)
            }
        }.onAppear {
            self.getAllUsers()
            self.getFollowing()
        }
    }
    
    func getAllUsers() {
        let reference = Database.database().reference().child("users")
        reference.observe(.value) { (snapshot) in
            self.allUsers.removeAll()
            for child in snapshot.children {
                if let childData = child as? DataSnapshot {
                    let uid = childData.key
                    let name = (childData.value as? String) ?? "No name"
                    self.allUsers.append(TwitterUser(name: name, uid: uid))
                    
                    
                }
            }
            print(self.allUsers)
        }
    }
    
    func getFollowing() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let reference = Database.database().reference().child("followers").child(currentUser.uid)
        reference.observe(.value) { (snapshot) in
            self.followingUsers.removeAll()
            for child in snapshot.children {
                if let childData = child as? DataSnapshot {
                    let uid = childData.key
                    let name = (childData.value as? String) ?? "No name"
                    self.followingUsers.append(TwitterUser(name: name, uid: uid))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
