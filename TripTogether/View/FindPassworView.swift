//
//  FindPassworView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/06/20.
//

import SnapKit
import UIKit

class FindPassworView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "아이디를 입력해주세요"
        tf.autocorrectionType = .no // 자동 수정 활성화 여부
        tf.spellCheckingType = .no // 맞춤법 검사 활성화 여부
        tf.autocapitalizationType = .none // 자동 대문자 활성화 여부
        tf.clearButtonMode = .always // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.clearsOnBeginEditing = false // 편집 시 기존 텍스트필드값 제거?
        return tf
    }()

    lazy var emailView: UIView = {
        let vw = UIView()
        vw.addSubview(emailTextField)
        vw.layer.cornerRadius = 5
        vw.layer.borderWidth = 1
        return vw
    }()

    lazy var findButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()

    func setupUI() {
        addSubview(emailView)
        addSubview(findButton)

        emailView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        findButton.snp.makeConstraints {
            $0.top.equalTo(emailView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(emailView).inset(10)
            $0.centerX.centerY.equalTo(emailView)
        }
    }
}
