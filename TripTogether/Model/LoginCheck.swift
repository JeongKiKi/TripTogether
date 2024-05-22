//
//  LoginCheck.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import Foundation
extension UserDefaults {
    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
    }
    
    var isLoggedIn: Bool {
        get {
            return bool(forKey: Keys.isLoggedIn)
        }
        set {
            set(newValue, forKey: Keys.isLoggedIn)
        }
    }
}
class LoginCheck {
    var loginCheck: Bool = false
}
