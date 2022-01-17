//
//  LoginPageModel.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI
import FirebaseAuth

class LoginPageModel: ObservableObject {
    
    //Login Properties
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    
    // Register Properties
    @Published var registerUser: Bool = false
    @Published var reEnterPassword: String = ""
    @Published var showReEnterPassword: Bool = false
    @Published var enterName: String = ""
    
    // Log Status
    @AppStorage("log_Status") var log_Status: Bool = false
    
    // Login Call
    func Login() {
        withAnimation {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard self != nil else { return }
                
              // ...
            }
            log_Status = true
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
          
            log_Status = false
        }
    }
    
    func Register() {
        withAnimation {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
              // ...
                print("Error has occured: \(String(describing: error))")
            }
            log_Status = true
        }
    }
    
    func forgotPassword() {
        
    }
    
}
