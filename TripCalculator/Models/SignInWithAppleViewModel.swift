//
//  SignInWithAppleViewModel.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import AuthenticationServices

class SignInWithAppleViewModel: NSObject, ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential {
        case let appleIdCredential as ASAuthorizationAppleIDCredential:
            print("\n ** ASAuthorizationAppleIdCredential - \(#function)** \n")
            print(appleIdCredential.email ?? "Email not available.")
            print(appleIdCredential.fullName ?? "fullname not available")
            print(appleIdCredential.fullName?.givenName ?? "givenName not available")
            print(appleIdCredential.fullName?.familyName ?? "Familyname not available")
            print(appleIdCredential.user)  // This is a user identifier
            print(appleIdCredential.identityToken?.base64EncodedString() ?? "Identity token not available") //JWT Token
            print(appleIdCredential.authorizationCode?.base64EncodedString() ?? "Authorization code not available")
            break
            
        case let passwordCredential as ASPasswordCredential:
            print("\n ** ASPasswordCredential ** \n")
            print(passwordCredential.user)
            print(passwordCredential.password)
            break
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("\n -- ASAuthorizationControllerDelegate -\(#function) -- \n")
        print(error)
    }
}

extension SignInWithAppleViewModel {
    private func registerNewUser(credential: ASAuthorizationAppleIDCredential) {
        
    }
    
    private func signInExistingUser(credential: ASAuthorizationAppleIDCredential) {
        
    }
    
    private func signInWithUserNamePassword(credential: ASPasswordCredential) {
        
    }
}
