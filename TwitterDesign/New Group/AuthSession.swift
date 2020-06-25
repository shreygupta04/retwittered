//
//  AuthSession.swift
//  TwitterDesign
//
//  Created by Shrey Gupta on 6/22/20.
//  Copyright © 2020 Shrey Gupta. All rights reserved.
//

import SwiftUI
import Combine
import Firebase

class AuthSession: NSObject, ObservableObject {
    let objectWillChange: ObservableObjectPublisher = ObservableObjectPublisher()
    
    @Published var user: User? {
        willSet {
            objectWillChange.send()
        }
    }
    
    private var authListener: AuthStateDidChangeListenerHandle?
    
    func startListening() {
        authListener = Auth.auth().addStateDidChangeListener({ (auth, updatedUser) in
            self.user = updatedUser
        })
    }
}
