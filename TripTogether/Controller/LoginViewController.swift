//
//  LoginViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
    }

    override func loadView() {
        super.loadView()
        view = loginView
    }

    private func setupActions() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }

    @objc private func loginButtonTapped() {
        UserDefaults.standard.isLoggedIn = true
        print("loginbtn")
        switchToMainTabBarController()
    }

    // 로그인이 되어있는 경우
    private func switchToMainTabBarController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.switchToMainTabBarController()
    }

    
}
