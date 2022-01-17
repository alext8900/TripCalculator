//
//  HomeViewHeader.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/9/21.
//

import SwiftUI

struct HomeViewHeader: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemIndigo).opacity(0.08))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: getRect().height / 3.5)
            HStack {
                VStack(alignment: .leading) {
                    Text("Southaven")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                    Text(Date.now, format: .dateTime.weekday(.wide).month().day())
                        .font(.callout)
                    Text("36˚ F")
                        .font(.system(size: 50, weight: .semibold, design: .default))
                        .foregroundColor(Color(UIColor.systemIndigo))
                    Text("Sunny with Showers")
                    Spacer()
                        .frame(height: 75)
                    
                    
                }
                Spacer()
                    .frame(width: 100)
                VStack(alignment: .leading) {
                    Image(systemName: "cloud.sun")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 60)
                        .foregroundColor(Color(UIColor.systemIndigo))
                    Spacer()
                        .frame(height: 150)
                    
                    
                }
            }
        }
    }
}

struct HomeViewHeader_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewHeader()
            .previewLayout(.sizeThatFits)
            .padding()
.previewInterfaceOrientation(.portrait)
            
    }
}
