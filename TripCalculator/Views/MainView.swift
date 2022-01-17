//
//  MainView.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/5/21.
//

import SwiftUI

struct MainView: View {
    @State var currentTab: Tab = .Home
    
    // Hiding tab bar..
    init() {
        UITabBar.appearance().isHidden = true
    }
    var body: some View {
        
        VStack(spacing: 0) {
            TabView(selection: $currentTab) {
                Home()
                    .tag(Tab.Home)
                
                Text("Discover")
                    .tag(Tab.Discover)
                
                Text("Route")
                    .tag(Tab.Route)
                
                Profile()
                    .tag(Tab.Profile)
            }
            
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.self) { tab in
                    
                    Button {
                        currentTab = tab
                    } label: {
                        Image(systemName: tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color(UIColor.systemIndigo)
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // blurring
                                    .blur(radius: 5)
                                // making big
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1: 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color(UIColor.systemIndigo) : Color.black.opacity(0.3))
                    }

                }
            }
            .padding([.horizontal, .top])
            .padding(.bottom, 10)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

enum Tab: String, CaseIterable {
    case Home = "house.fill"
    case Discover = "magnifyingglass"
    case Route = "mappin"
    case Profile = "person.crop.circle.fill"
}
