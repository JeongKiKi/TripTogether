//
//  MakeEmailView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/22.
//

import SnapKit
import UIKit

class MakeEmailView: UIView {
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
        tf.placeholder = "이메일을 입력해주세요"
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

    lazy var emailLabel: UILabel = {
        let lb = UILabel()
        lb.text = "사용할 이메일을 입력해주세요"
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()

    lazy var emailTfLb: UIView = {
        let st = UIView()
        st.addSubview(emailView)
        st.addSubview(emailLabel)
        return st
    }()

    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 입력해주세요"
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no // 자동 수정 활성화 여부
        tf.spellCheckingType = .no // 맞춤법 검사 활성화 여부
        tf.autocapitalizationType = .none // 자동 대문자 활성화 여부
        tf.clearButtonMode = .always // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.clearsOnBeginEditing = false // 편집 시 기존 텍스트필드값 제거?
        return tf
    }()

    lazy var passwordView: UIView = {
        let vw = UIView()
        vw.addSubview(passwordTextField)
        vw.layer.cornerRadius = 5
        vw.layer.borderWidth = 1
        return vw
    }()

    lazy var passwordLabel: UILabel = {
        let lb = UILabel()
        lb.text = "6글자 이상의 비밀번호를 입력해주세요"
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()

    lazy var passwordTfLb: UIView = {
        let st = UIView()
        st.addSubview(passwordView)
        st.addSubview(passwordLabel)
        return st
    }()

    lazy var passwordCheckTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 다시 입력해주세요"
        tf.isSecureTextEntry = true
        tf.autocorrectionType = .no // 자동 수정 활성화 여부
        tf.spellCheckingType = .no // 맞춤법 검사 활성화 여부
        tf.autocapitalizationType = .none // 자동 대문자 활성화 여부
        tf.clearButtonMode = .always // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.clearsOnBeginEditing = false // 편집 시 기존 텍스트필드값 제거?
        return tf
    }()

    lazy var passwordCheckView: UIView = {
        let vw = UIView()
        vw.addSubview(passwordCheckTextField)
        vw.layer.cornerRadius = 5
        vw.layer.borderWidth = 1
        return vw
    }()

    lazy var passwordCheckLabel: UILabel = {
        let lb = UILabel()
        lb.text = "비밀번호를 다시 입력해주세요"
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()

    lazy var passwordCheckTfLb: UIView = {
        let st = UIView()
        st.addSubview(passwordCheckView)
        st.addSubview(passwordCheckLabel)
        return st
    }()

    lazy var nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임을 입력해주세요"
        tf.autocorrectionType = .no // 자동 수정 활성화 여부
        tf.spellCheckingType = .no // 맞춤법 검사 활성화 여부
        tf.autocapitalizationType = .none // 자동 대문자 활성화 여부
        tf.clearButtonMode = .always // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.clearsOnBeginEditing = false // 편집 시 기존 텍스트필드값 제거?
        return tf
    }()

    lazy var nickNameView: UIView = {
        let vw = UIView()
        vw.addSubview(nickNameTextField)
        vw.layer.cornerRadius = 5
        vw.layer.borderWidth = 1
        return vw
    }()

    lazy var nickNameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "닉네임을 입력해주세요"
        lb.font = .systemFont(ofSize: 13)
        return lb
    }()

    lazy var nickNameTfLb: UIView = {
        let st = UIView()
        st.addSubview(nickNameView)
        st.addSubview(nickNameLabel)
        return st
    }()

    lazy var createButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        btn.backgroundColor = .systemBlue
        return btn
    }()
}

extension MakeEmailView {
    func setupUI() {
        addSubview(emailTfLb)
        addSubview(passwordTfLb)
        addSubview(passwordCheckTfLb)
        addSubview(nickNameTfLb)
        addSubview(createButton)
        emailTfLb.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        passwordTfLb.snp.makeConstraints {
            $0.top.equalTo(emailTfLb.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        passwordCheckTfLb.snp.makeConstraints {
            $0.top.equalTo(passwordTfLb.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        nickNameTfLb.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTfLb.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        createButton.snp.makeConstraints {
            $0.top.equalTo(nickNameTfLb.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
        emailTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(emailView).inset(10)
            $0.centerY.equalTo(emailView.snp.centerY)
        }
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(passwordView).inset(10)
            $0.centerY.equalTo(passwordView.snp.centerY)
        }
        passwordCheckTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(passwordCheckView).inset(10)
            $0.centerY.equalTo(passwordCheckView.snp.centerY)
        }
        nickNameTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(nickNameView).inset(10)
            $0.centerY.equalTo(nickNameView.snp.centerY)
        }
        emailView.snp.makeConstraints {
            $0.top.equalTo(emailTfLb.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(emailView.snp.bottom).offset(2)
        }
        passwordView.snp.makeConstraints {
            $0.top.equalTo(passwordTfLb.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        passwordLabel.snp.makeConstraints {
            $0.top.equalTo(passwordView.snp.bottom).offset(2)
        }
        passwordCheckView.snp.makeConstraints {
            $0.top.equalTo(passwordCheckTfLb.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        passwordCheckLabel.snp.makeConstraints {
            $0.top.equalTo(passwordCheckView.snp.bottom).offset(2)
        }
        nickNameView.snp.makeConstraints {
            $0.top.equalTo(nickNameTfLb.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
        nickNameLabel.snp.makeConstraints {
            $0.top.equalTo(nickNameView.snp.bottom).offset(2)
        }
    }
}
