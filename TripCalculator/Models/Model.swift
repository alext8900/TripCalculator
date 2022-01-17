//
//  Model.swift
//  TripCalculator
//
//  Created by Alex Thompson on 12/4/21.
//

import Foundation
import SwiftUI

class UserAuth: ObservableObject {
    @Published var isLoggedin: Bool = false
    
    func logout() {
        withAnimation {
            self.isLoggedin = false
        }
        
    }

    func login() {
        withAnimation {
            self.isLoggedin = true
        }
        
    }
    
}
