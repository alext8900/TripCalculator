//
//  LoginPageModel.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI

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
            log_Status = true
        }
    }
    
    func Logout() {
        withAnimation {
            log_Status = false
        }
    }
    
    func Register() {
        withAnimation {
            log_Status = true
        }
    }
    
    func forgotPassword() {
        
    }
    
}
