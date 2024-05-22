//
//  MakeEmailViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import FirebaseAuth
import UIKit
class MakeEmailViewController: UIViewController {
    let makeEmailView = MakeEmailView()
    let loginCheck = LoginCheck()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = makeEmailView
        setupActions()
        title = "회원가입"
    }

    private func setupActions() {
        makeEmailView.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }

    @objc private func createButtonTapped() {
        print("비밀번호 찾기 버튼 눌림")
        guard let email = makeEmailView.emailTextField.text, !email.isEmpty,
              let password = makeEmailView.passwordTextField.text, !password.isEmpty,
              let passwordCheck = makeEmailView.passwordCheckTextField.text, !passwordCheck.isEmpty
        else {
            print("모든 필드를 입력해주세요.")
            return
        }

        guard password == passwordCheck else {
            print("비밀번호가 일치하지 않습니다.")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            guard let self = self else { return }
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
                return
            }

            print("회원가입 성공")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
//            loginCheck.switchToMainTabBarController()
        }
        navigationController?.popViewController(animated: true)
    }
}
