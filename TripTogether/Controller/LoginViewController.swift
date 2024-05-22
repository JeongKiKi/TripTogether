//
//  LoginViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import FirebaseAuth
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
        loginView.makeEmailButton.addTarget(self, action: #selector(makeEmailButtonTapped), for: .touchUpInside)
        loginView.findPasswordButton.addTarget(self, action: #selector(findPasswordButtonTapped), for: .touchUpInside)
    }

    @objc private func loginButtonTapped() {
        guard let email = loginView.idTextField.text, !email.isEmpty,
              let password = loginView.passwordTextField.text, !password.isEmpty
        else {
            print("Email and password fields cannot be empty")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
                print("아이디 비번 틀림")
                return
            }

            UserDefaults.standard.isLoggedIn = true
            print("Successfully logged in")
            self.switchToMainTabBarController()
        }
    }

    @objc private func makeEmailButtonTapped() {
        print("회원가입 버튼 눌림")
        let makeEmail = MakeEmailViewController()
        navigationController?.pushViewController(makeEmail, animated: true)
    }

    @objc private func findPasswordButtonTapped() {
        print("비밀번호 찾기 버튼 눌림")
    }

    // 로그인이 되어있는 경우
    private func switchToMainTabBarController() {
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        sceneDelegate?.switchToMainTabBarController()
    }
}
