//
//  LoginCheck.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import UIKit
extension UserDefaults {
    private enum Keys {
        static let isLoggedIn = "isLoggedIn"
        static let uid = "uid"
        static let nickName = "nickName"
        static let like = "like"
        static let liked = "liked"
    }

    var isLoggedIn: Bool {
        get {
            return bool(forKey: Keys.isLoggedIn)
        }
        set {
            set(newValue, forKey: Keys.isLoggedIn)
        }
    }

    var uid: String? {
        get {
            return string(forKey: Keys.uid)
        }
        set {
            set(newValue, forKey: Keys.uid)
        }
    }

    var nickName: String? {
        get {
            return string(forKey: Keys.nickName)
        }
        set {
            set(newValue, forKey: Keys.nickName)
        }
    }

    var like: String? {
        get {
            return string(forKey: Keys.like)
        }
        set {
            set(newValue, forKey: Keys.like)
        }
    }

    var liked: String? {
        get {
            return string(forKey: Keys.liked)
        }
        set {
            set(newValue, forKey: Keys.liked)
        }
    }
}

class LoginCheck {
    var loginCheck: Bool = false

    func switchToMainTabBarController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.switchToMainTabBarController()
    }

    func switchToLoginViewController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.switchToLoginViewController()
    }
}
