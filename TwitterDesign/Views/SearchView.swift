//
//  SearchView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/17/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @State private var currentCategory = 0
    private let categories = [
        "For you",
        "COVID-19",
        "Trending",
        "News",
        "Sport",
        "Fun",
        "Entertainment"
    ]
    
    private let trends = [
        Trend(type: "COVID-19", name: "COVID-19: Updated for the US", num_tweets: "100K"),
        Trend(type: "Gaming", name: "Last of Us Part II", num_tweets: "240K"),
        Trend(type: "News", name: "John Bolton new book bashes Trump", num_tweets: "310K"),
        Trend(type: "Politics", name: "NO ONE LIKES YOU", num_tweets: "41.6K"),
        Trend(type: "Gaming", name: "Gamers are mad at Rockstar", num_tweets: "43K")
    ]
    
    var body: some View {
        VStack {
            TextField("Search Twitter", text: $searchText)
                .frame(height: 36, alignment: .center)
                .padding(.horizontal, 24)
                .background(Color.black.opacity(0.07))
                .cornerRadius(18)
                .padding(.horizontal, 32)
                .multilineTextAlignment(.center)
                .font(Font.montserratFont(size: 16))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0..<categories.count) { i in
                        Button(action: {
                            self.currentCategory = i
                        }) {
                            VStack(spacing: 7) {
                                Text(self.categories[i])
                                    .padding(.horizontal, 8)
                                    .padding(.horizontal, 16)
                                    .font(Font.montserratFont(size: 16, isBold: true))
                                    .foregroundColor(i == self.currentCategory ? Color.twitterBlue : Color.gray)
//                                Divider()
//                                    .frame(height: 2)
//                                    .background(i == self.currentCategory ? Color.twitterBlue : Color.white)
                            }
                        }
                        
                    }
                }
            }
            
            List {
                ZStack(alignment: .bottom) {
                    Image("blm")
                        .resizable()
                    VStack(alignment: .leading) {
                        Spacer()
                            .frame(height: 30)
                        Text("US News – LIVE")
                            .font(Font.montserratFont(size: 12, isBold: true))
                            .foregroundColor(.white)
                        Text("US Black Lives Matter Protest")
                            .font(Font.montserratFont(size: 24, isBold: true))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.black.opacity(0.5), Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top))
                }
                .frame(height: 200)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                ForEach(self.trends) { trend in
                    TrendCell(trend: trend)
                }
            }
        }
    .navigationBarTitle("")
    .navigationBarHidden(true)
    }
}

struct TrendCell: View {
    var trend: Trend
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(trend.type) - Trending")
                .font(Font.montserratFont(size: 12))
                .foregroundColor(Color.black.opacity(0.7))
            
            Text(trend.name)
                .font(Font.montserratFont(size: 16, isBold: true))
            Text("\(trend.num_tweets) - Trending")
                .font(Font.montserratFont(size: 12))
                .foregroundColor(Color.black.opacity(0.7))
        }
        .padding(.vertical, 8)
    }
}

struct Trend: Identifiable {
    var type: String
    var name: String
    var num_tweets: String
    var id: String {
        return self.name
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
