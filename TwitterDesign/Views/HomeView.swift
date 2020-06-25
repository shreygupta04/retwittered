//
//  HomeView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/17/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Firebase

struct HomeView: View {
    @State private var tweets = [Tweet]()
    @Binding var followingUsers: [TwitterUser]
    
    @State private var query: Query?
    
    var refresh: some View {
        Button(action: {
            self.getTweets()
        }) {
            Image(systemName: "arrow.clockwise")
                .foregroundColor(Color.twitterBlue)
                .font(Font.system(size: 24))
        }
    }

    var body: some View {
        List {
            ForEach(tweets) { tweet in
                VStack(alignment: .leading) {
                    HStack {
                        Text(tweet.account.name)
                            .font(Font.system(size: 18, weight: .bold))
                        Spacer()
                        Text(tweet.displayDate)
                            .font(Font.system(size: 14))
                            .opacity(0.5)
                    }
                    
                    Text(tweet.text)
                        .font(Font.system(size: 16))
                        .padding(.top, 8)
                    Button(action: {
                        if tweet.likes.contains(Auth.auth().currentUser?.uid ?? "") {
                            self.unlikeTweet(tweet: tweet)
                        }
                        else {
                            self.likeTweet(tweet: tweet)
                        }
                    }) {
                        HStack {
                            Text("\(tweet.likes.count)")
                            Image(systemName: "heart")
                        }
                        .foregroundColor(tweet.likes.contains(Auth.auth().currentUser?.uid ?? "") ? Color.pink : Color.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(16)
            }
        }
        .navigationBarTitle("Retwittered", displayMode: .inline)
        .navigationBarItems(leading: refresh)
        .onAppear {
            self.getTweets()
        }
    }
    
    func unlikeTweet(tweet: Tweet) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let reference = Firestore.firestore().collection("tweets").document(tweet.id)
        var newLikes = tweet.likes
        
        if let myIndex = newLikes.firstIndex(of: currentUser.uid) {
            newLikes.remove(at: myIndex)
            let updateData: [String: Any] = [
                "likes": newLikes
            ]
            reference.updateData(updateData)
        }
    }
    
    func likeTweet(tweet: Tweet) {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let reference = Firestore.firestore().collection("tweets").document(tweet.id)
        var newLikes = tweet.likes
        newLikes.append(currentUser.uid)
        let updateData: [String: Any] = [
            "likes": newLikes
        ]
        reference.updateData(updateData)
    }
    
    func getTweets() {
        
        var followingUserIds = followingUsers.map { $0.uid }
        
        if let currentUser = Auth.auth().currentUser {
            followingUserIds.append(currentUser.uid)
        }
        
        let reference = Firestore.firestore().collection("tweets")
        query = reference.whereField("accountId", in: followingUserIds)
        query?.addSnapshotListener { (snapshot, error) in
            if let queryError = error {
                print("Error getting tweets \(queryError)")
                return
            }
            if let querySnapshot = snapshot {
                self.tweets.removeAll()
                for document in querySnapshot.documents {
                    let data = document.data()
                    
                    let text = data["text"] as? String
                    let postDate = data["postDate"] as? Date
                    let likes = data["likes"] as? [String]
                    let accountId = data["accountId"] as? String
                    let accountName = data["accountName"] as? String
                    
                    let account = TwitterUser(name: accountName ?? "", uid: accountId ?? "")
                    
                    let tweet = Tweet(text: text ?? "", account: account, postDate: postDate ?? Date(), likes: likes ?? [], id: document.documentID)
                    
                    self.tweets.append(tweet)
                }
            }
        }
    }
}
