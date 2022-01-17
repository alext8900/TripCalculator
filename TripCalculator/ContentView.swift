//
//  ContentView.swift
//  TripCalculator
//
//  Created by Alex Thompson on 11/23/21.
//

import SwiftUI

struct ContentView: View {
    // Log status
    @AppStorage("log_Status") var log_Status: Bool = false
    @AppStorage("has_Onboarded") var has_Onboarded: Bool = false
    var body: some View {
        Group {
            if log_Status {
                MainView()
            } else {
                switch has_Onboarded {
                case true: NewLogin()
                case false: OnboardingPage()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
