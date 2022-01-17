//
//  Home.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .bottom) {
                    HomeViewHeader()
                        .frame(width: 360, height: 320, alignment: .center)
                    HStack(spacing: 25) {
                        HomeViewButton(imageName: "magnifyingglass", title: "Discover")
                        HomeViewButton(imageName: "car.fill", title: "Requests")
                        HomeViewButton(imageName: "envelope.open.fill", title: "Messages")
                    }
                    
                    
                        .navigationTitle("Hello Alex!")
                }
                VStack() {
                    Button {
                        
                    } label: {
                        Text("Create a route")
                            .font(.system(size: 18, weight: .semibold, design: .default))
                            .padding(.vertical, 18)
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor.systemIndigo))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 5, y: 5)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical)
                }
                
                HStack {
                    Text("Past Trips")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .padding(.horizontal, 20)
                    
                    Spacer()
                }
                
                VStack {
                    Text("No trips made yet.")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.gray.opacity(0.4))
                        .padding(.vertical, 100)
                }
                
            }
            
            
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
