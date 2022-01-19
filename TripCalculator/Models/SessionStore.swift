//
//  SessionStore.swift
//  TripCalculator
//
//  Created by Alex Thompson on 1/18/22.
//

import SwiftUI
import FirebaseAuth
import Combine

class SessionStore: ObservableObject {
    
    let auth = Auth.auth()
    
    //Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    @Published var signedIn = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    @Published var enterName: String = ""
    
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener({ auth, user in
            if let user = user {
                // if we have a user, create a new user model
                print("Got user: \(user)")
                self.session = User(uid: user.uid, email: user.email, displayName: user.displayName)
            } else {
                // if we dont have a user set our session to nil
                self.session = nil
            }
        })
    }
    
    func Login(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        withAnimation {
            Auth.auth().signIn(withEmail: email, password: password, completion: handler)
        }
    }
    
    func Logout() {
        withAnimation {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.session = nil
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
    }
    
    func Register(email: String, password: String, handler: @escaping AuthDataResultCallback) {
        withAnimation {
            Auth.auth().createUser(withEmail: email, password: password, completion: handler)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.registerUser.toggle()
            }
        }
    }
    
    func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("There was an error: \(error)")
            }
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
