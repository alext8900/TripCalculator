//
//  SignInWithAppleButton.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/4/21.
//

import SwiftUI
import AuthenticationServices

final class SignInWithApple: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}

