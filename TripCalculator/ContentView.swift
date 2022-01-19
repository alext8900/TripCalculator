//
//  ContentView.swift
//  TripCalculator
//
//  Created by Alex Thompson on 11/23/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    // Log status
    @AppStorage("log_Status") var log_Status: Bool = false
    @AppStorage("has_Onboarded") var has_Onboarded: Bool = false
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body: some View {
        Group {
            if (session.session != nil) {
                MainView()
            } else {
                switch has_Onboarded {
                case true: NewLogin()
                case false: OnboardingPage()
                }
            }
        }.onAppear {
            self.getUser()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
