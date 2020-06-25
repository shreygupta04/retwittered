//
//  BaseView.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/22/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI

struct BaseView: View {
    
    @ObservedObject var authSession = AuthSession()
    
    var body: some View {
        Group {
            if authSession.user != nil {
                ContentView()
            }
            else {
                OnboardView()
            }
        }
        .onAppear() {
            self.authSession.startListening()
        }
    }
}

struct BaseView_Previews: PreviewProvider {
    static var previews: some View {
        BaseView()
    }
}
