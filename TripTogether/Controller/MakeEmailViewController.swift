//
//  MakeEmailViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import UIKit

class MakeEmailViewController: UIViewController {
    let makeEmailView = MakeEmailView()
    let firebaseManager = FirebaseManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = makeEmailView
        view.backgroundColor = .appColor
        setupActions()
        title = "회원가입"
    }

    private func setupActions() {
        makeEmailView.createButton.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
    }

    @objc private func createButtonTapped() {
        guard let email = makeEmailView.emailTextField.text, !email.isEmpty,
              let password = makeEmailView.passwordTextField.text, !password.isEmpty,
              let passwordCheck = makeEmailView.passwordCheckTextField.text, !passwordCheck.isEmpty,
              let nickname = makeEmailView.nickNameTextField.text, !nickname.isEmpty
        else {
            print("모든 필드를 입력해주세요.")
            return
        }

        guard password == passwordCheck else {
            print("비밀번호가 일치하지 않습니다.")
            makeEmailView.passwordLabel.text = "비밀번호가 일치하지 않습니다."
            makeEmailView.passwordCheckLabel.text = "비밀번호가 일치하지 않습니다."
            return
        }

        // FirebaseManager를 사용하여 회원가입 시도
        firebaseManager.registerUser(withEmail: email, password: password, nickname: nickname) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                print("회원가입 성공")
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print("회원가입 실패: \(error.localizedDescription)")
            }
        }
    }
}
