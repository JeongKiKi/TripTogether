//
//  LoginView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import SnapKit
import UIKit
class LoginView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "아이디를 입력해주세요"
        return tf
    }()

    lazy var idView: UIView = {
        let vw = UIView()
        vw.addSubview(idTextField)
        vw.layer.cornerRadius = 5
        vw.layer.borderWidth = 1
        return vw
    }()

    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "비밀번호를 입력해주세요"
        return tf
    }()

    lazy var passwordView: UIView = {
        let vw = UIView()
        vw.addSubview(passwordTextField)
        vw.layer.cornerRadius = 5
        vw.layer.borderWidth = 1
        return vw
    }()

    lazy var loginButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()

    lazy var makeEmailButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()

    lazy var findPasswordButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("비밀번호 찾기", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()

    lazy var makeStack: UIStackView = {
        let st = UIStackView()
        st.axis = .horizontal
        st.spacing = 10
        st.alignment = .fill
        st.distribution = .fillEqually
        [makeEmailButton, findPasswordButton].forEach { st.addArrangedSubview($0) }
        return st
    }()

    lazy var idPasswodrStack: UIStackView = {
        let st = UIStackView()
        st.axis = .vertical
        st.spacing = 10
        st.alignment = .fill
        st.distribution = .fillEqually
        [idView, passwordView].forEach { st.addArrangedSubview($0) }
        return st
    }()

    func setupUI() {
        addSubview(idPasswodrStack)
        addSubview(loginButton)
        addSubview(makeStack)
        idPasswodrStack.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(100)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(100)
        }
        idTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(idView).inset(10)
            $0.centerX.centerY.equalTo(idView)
        }
        passwordTextField.snp.makeConstraints {
            $0.leading.trailing.equalTo(passwordView).inset(10)
            $0.centerX.centerY.equalTo(passwordView)
        }
        loginButton.snp.makeConstraints {
            $0.top.equalTo(idPasswodrStack.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(50)
        }
        makeStack.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(loginButton)
            $0.height.equalTo(50)
        }
    }
}
