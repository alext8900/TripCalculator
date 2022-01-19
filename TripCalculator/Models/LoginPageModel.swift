//
//  LoginPageModel.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI
import FirebaseAuth

let actionCodeSettings = ActionCodeSettings()

class LoginPageModel: ObservableObject {
    // Firebase Property
    let auth = Auth.auth()
    
    //Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    @Published var signedIn = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    @Published var enterName: String = ""
    
    // Log Status
    @AppStorage("log_Status") var log_Status: Bool = false
    
    // Login Call
    func Login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            withAnimation {
                DispatchQueue.main.async {
                    self?.signedIn = true
                }
            }
        }
    }
    
    func Logout() {
        withAnimation {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
            } catch let signOutError as NSError {
                print("Error signing out: %@", signOutError)
            }
        }
    }
    
    func Register(email: String, password: String) {
        withAnimation {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            }
            log_Status = true
        }
    }
    
    func forgotPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("There was an error: \(error)")
            }
        }
    }
    
}
