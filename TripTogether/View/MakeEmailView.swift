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
        lb.text = "aaa"
        return lb
    }()

    lazy var emailStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailView, emailLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
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
        lb.text = "bb"
        return lb
    }()

    lazy var passwordStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [passwordView, passwordLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
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
        lb.text = "ccc"
        return lb
    }()

    lazy var passwordCheckStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [passwordCheckView, passwordCheckLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
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
        lb.text = "aaa"
        return lb
    }()

    lazy var nickNameStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [nickNameView, nickNameLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
        return st
    }()

    lazy var createButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()
}

extension MakeEmailView {
    func setupUI() {
        addSubview(emailStack)
        addSubview(passwordStack)
        addSubview(passwordCheckStack)
        addSubview(nickNameStack)
        addSubview(createButton)
        emailStack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        passwordStack.snp.makeConstraints {
            $0.top.equalTo(emailStack.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        passwordCheckStack.snp.makeConstraints {
            $0.top.equalTo(passwordStack.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        nickNameStack.snp.makeConstraints {
            $0.top.equalTo(passwordCheckStack.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(80)
        }
        createButton.snp.makeConstraints {
            $0.top.equalTo(nickNameStack.snp.bottom).offset(10)
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
    }
}
