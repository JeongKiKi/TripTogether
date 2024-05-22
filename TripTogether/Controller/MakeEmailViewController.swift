//
//  MakeEmailViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import UIKit

class MakeEmailViewController: UIViewController {
    let makeEmailView = MakeEmailView()
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
        navigationController?.popViewController(animated: true)
    }
}
