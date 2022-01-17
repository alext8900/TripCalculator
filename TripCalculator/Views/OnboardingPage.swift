//
//  OnboardingPage.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI

struct OnboardingPage: View {
    // Showing Login Page...
    @State var showLoginPage: Bool = false
    @AppStorage("has_Onboarded") var has_Onboarded: Bool = false
    var body: some View {
        
        VStack(alignment: .leading) {
            Text("Drive your\nVehicle")
                .font(.system(size: 50, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Image("truck")
                .resizable()
                .aspectRatio(contentMode: .fit)
//
//                .padding(.top, 75)
                .padding(.bottom, 100)
            
            Button {
                withAnimation {
                    showLoginPage = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    has_Onboarded = true
                }
            } label: {
                Text("Get started")
                    .font(.system(size: 18, weight: .semibold, design: .default))
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                    .foregroundColor(Color(UIColor.systemIndigo))
            }
            .padding(.horizontal, 30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
        }
        .padding()
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color(UIColor.systemIndigo)
        )
        .overlay(
            Group {
                if showLoginPage {
                    NewLogin()
                        .transition(.move(edge: .bottom))
                }
            }
        )
    }
}

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage()
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
