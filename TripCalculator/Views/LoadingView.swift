//
//  LoadingView.swift
//  TripCalculator
//
//  Created by Alex Thompson on 1/18/22.
//

import SwiftUI

struct LoadingView: View {
    @State var shouldAnimate: Bool = false
    var body: some View {
        Circle()
            .fill(Color.indigo)
            .frame(width: 30, height: 30)
            .overlay(
                ZStack {
                    Circle()
                        .stroke(Color.indigo, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 1: 0)
                    Circle()
                        .stroke(Color.indigo, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 1.5 : 0)
                    Circle()
                        .stroke(Color.indigo, lineWidth: 100)
                        .scaleEffect(shouldAnimate ? 2: 0)
                }
                    .opacity(shouldAnimate ? 0.0 : 0.2)
                    .animation(Animation.easeOut(duration: 1).repeatForever(autoreverses: false))
            )
            .onAppear {
                self.shouldAnimate = true
            }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
