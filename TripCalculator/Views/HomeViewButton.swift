//
//  HomeViewButton.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/11/21.
//

import SwiftUI

struct HomeViewButton: View {
    
    var imageName: String
    var title: String
    
    var body: some View {
        VStack(alignment: .center) {
            Button {
                print("Has been tapped")
            } label: {
                Image(systemName: imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(width: 100, height: 100, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(25)
                    .foregroundColor(Color(UIColor.systemIndigo))
                    .shadow(color: .black.opacity(0.1), radius: 7, x: 4, y: 5)
            }
            
            Text(title)
                .font(.system(size: 12, weight: .semibold, design: .default))
        }

    }
}

struct HomeViewButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewButton(imageName: "magnifyingglass", title: "Discover")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
