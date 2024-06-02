//
//  MakeEmailViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit
class MakeEmailViewController: UIViewController {
    let db = Firestore.firestore()
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
              let passwordCheck = makeEmailView.passwordCheckTextField.text, !passwordCheck.isEmpty,
              let nickname = makeEmailView.nickNameTextField.text, !nickname.isEmpty
        else {
            print("모든 필드를 입력해주세요.")
            return
        }

        guard password == passwordCheck else {
            print("비밀번호가 일치하지 않습니다.")
            return
        }
        // 회원가입
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                print("회원가입 실패: \(error.localizedDescription)")
                return
            }
            // 문서를 uid로 지정하기위해 uid 가져오기
            guard let uid = authResult?.user.uid else { return }

            // 로그인 상태 저장
            UserDefaults.standard.set(true, forKey: "isLoggedIn")

            // 회원가입 userinfo를 firebasestore에 저장
            db.collection("userInfo").document(uid).setData(["email": email,
                                                             "nickName": nickname,
                                                             "like": [], "liked": [], "uid": uid])
            { error in
                if let error = error {
                    print("There was an issue saving data to firestore, \(error)")
                } else {
                    print("Successfully saved data.")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
