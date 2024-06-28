//
//  FindPasswordViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/06/20.
//

import FirebaseAuth
import UIKit

class FindPasswordViewController: UIViewController {
    var findView = FindPassworView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view = findView
        view.backgroundColor = .appColor
        navigationItem.title = "비밀번호 찾기"
        findView.findButton.addTarget(self, action: #selector(findButtonTapped), for: .touchUpInside)
    }

    @objc func findButtonTapped() {
        guard let email = findView.emailTextField.text, !email.isEmpty else {
            showAlert(message: "이메일을 입력해주세요.", complete: false)
            return
        }
        // 이메일 형식 확인
        guard email.isValidEmail else {
            showAlert(message: "유효한 이메일을 입력해주세요.", complete: false)
            return
        }

        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.showAlert(message: "비밀번호 재설정 이메일 전송에 실패했습니다: \(error.localizedDescription)", complete: false)
                return
            }

            self.showAlert(message: "비밀번호 재설정 이메일이 전송되었습니다.", complete: true)
        }
    }

    // 이메일 입력에 따른 알럿창 생성
    func showAlert(message: String, complete: Bool) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let saveAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 비밀번호 재설정 이메일이 전송됬다면 화면 전환
            if complete {
                self.navigationController?.popViewController(animated: true)
            }
        }
        alertController.addAction(saveAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension String {
    // 이메일 형식 확인
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}
