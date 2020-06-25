//
//  TweetView.swift
//  
//
//  Created by Shrey Gupta on 6/24/20.
//

import SwiftUI
import Firebase

struct TweetView: View {
    
    @State var tweetText = ""
    @Binding var isShown: Bool
    
    var cancelButton: some View {
        Button(action: {
            self.isShown = false
        }) {
            Text("Cancel")
                .foregroundColor(Color.twitterBlue)
        }
    }
    
    var tweetButton: some View {
        Button(action: {
            self.tweet()
        }) {
            Text("Tweet")
                .frame(width: 80, height: 36)
                .background(Color.twitterBlue)
                .cornerRadius(18)
                .foregroundColor(.white)
                .font(Font.system(size: 16, weight: .bold))
                .opacity(tweetText == "" ? 0.4 : 1)
                .disabled(tweetText == "")
        }
    }
    
    var progressIndicator: some View {
        ZStack {
            Circle()
                .stroke(Color.gray, lineWidth: 3)
            PercentCircle(text: $tweetText)
                .stroke(Color.twitterBlue, lineWidth: 3)
        }
        .frame(width: 20, height: 20)
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextView(text: $tweetText)
            
            if tweetText == "" {
                Text("What's happening")
                    .font(Font.system(size: 20))
                    .padding(.horizontal, 6)
                    .padding(.vertical, 8)
                    .opacity(0.5)
            }
        }
        .padding(.horizontal, 16)
        .navigationBarTitle("  ", displayMode: .inline)
        .navigationBarItems(leading: HStack {cancelButton; progressIndicator}, trailing: tweetButton)
        .navigationBarBackButtonHidden(true)
    }
    
    func tweet() {
        guard let currentUser = Auth.auth().currentUser else {
            return
        }
        let data: [String: Any] = [
            "text": tweetText,
            "accountId": currentUser.uid,
            "accountName": currentUser.displayName ?? "Anonymous",
            "likes": [],
            "postDate": Date()
        ]
        let reference = Firestore.firestore().collection("tweets")
        reference.addDocument(data: data) { (error) in
            if let databaseError = error {
                print("Error tweeting  \(databaseError)")
                return
            }
            self.isShown = false
        }
    }
}
