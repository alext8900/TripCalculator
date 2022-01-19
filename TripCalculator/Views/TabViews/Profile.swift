//
//  Profile.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI

struct Profile: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    @AppStorage("has_Onboarded") var has_Onboarded: Bool = false
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        VStack {
            Button {
                self.session.Logout()
            } label: {
                Text("Logout")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
            }
            .buttonStyle(.bordered)
        .tint(Color(UIColor.systemIndigo))
            
            Button {
                withAnimation {
                    has_Onboarded = false
                }
            } label: {
                Text("Reset Onboarding")
                    .font(.system(size: 30, weight: .semibold, design: .rounded))
            }
            .buttonStyle(.bordered)
        .tint(Color(UIColor.systemIndigo))
        }

    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
