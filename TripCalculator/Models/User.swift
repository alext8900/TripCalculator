//
//  User.swift
//  TripCalculator
//
//  Created by Alex Thompson on 1/18/22.
//

import Foundation

class User {
    var uid: String
    var email: String?
    var displayName: String?
    
    init(uid: String, email: String?, displayName: String?) {
        self.uid = uid
        self.email = email
        self.displayName = displayName
    }
}
