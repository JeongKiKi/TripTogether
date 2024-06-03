//
//  LoginViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class LoginViewController: UIViewController {
    let loginView = LoginView()
    let loginCheck = LoginCheck()
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupActions()
        setupTextFieldDelegates()
        updateLoginButtonState()
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

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let self = self else { return }
            if let error = error {
                print("Error logging in: \(error.localizedDescription)")
                print("아이디 비번 틀림")
                loginView.idTextField.text = ""
                loginView.passwordTextField.text = ""
                loginView.idTextField.placeholder = "아이디를 확인해주세요"
                loginView.passwordTextField.placeholder = "비밀번호를 확인해주세요"
                updateLoginButtonState()
                return
            }

            print("Successfully logged in")
            guard let uid = authResult?.user.uid else { return }
            self.fetchUserData(uid: uid)
        }
    }

    // uid를 통해 유저 정보불러와 유저디폴트로 저장
    private func fetchUserData(uid: String) {
        db.collection("userInfo").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists,
                  let data = document.data(),
                  let nickName = data["nickName"] as? String,
                  let like = data["like"] as? [String],
                  let liked = data["liked"] as? [String]
            else {
                print("User data not found or malformed")
                return
            }

            UserDefaults.standard.isLoggedIn = true
            UserDefaults.standard.uid = uid
            UserDefaults.standard.nickName = nickName
            UserDefaults.standard.like = like
            UserDefaults.standard.liked = liked
            self.loginCheck.switchToMainTabBarController()
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
    
    //FieldDelegates설정
    private func setupTextFieldDelegates() {
        loginView.idTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }

    // 로그인버튼 활성화에 따른 버튼 ui변경
    func loginBtnOn() {
        if loginView.loginButton.isEnabled {
            loginView.loginButton.backgroundColor = .systemBlue
        } else {
            loginView.loginButton.backgroundColor = .lightGray
        }
    }

    // 아이디 비번 입력에 따라 로그인버튼 활성화
    private func updateLoginButtonState() {
        let isEmailFilled = !(loginView.idTextField.text?.isEmpty ?? true)
        let isPasswordFilled = !(loginView.passwordTextField.text?.isEmpty ?? true)
        loginView.loginButton.isEnabled = isEmailFilled && isPasswordFilled
        loginBtnOn()
    }
}

extension LoginViewController: UITextFieldDelegate {
    //텍스트 필드의 내용이 변경될 때마다 호출하여 버튼 상태 업데이트
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        DispatchQueue.main.async {
            self.updateLoginButtonState()
        }
        return true
    }
    //텍스트필드 내용 입력이 끝났을 때 상태 업데이트
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateLoginButtonState()
    }
}
