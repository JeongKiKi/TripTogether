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

    lazy var appTitle: UILabel = {
        let lb = UILabel()
        lb.text = "Trip Together"
        lb.textAlignment = .center
        lb.font = .boldSystemFont(ofSize: 30)
        return lb
    }()

    lazy var appSubTitle: UILabel = {
        let lb = UILabel()
        lb.text = "내가 가본 여행지를 자랑해 보아요"
        lb.textAlignment = .center
        lb.font = .systemFont(ofSize: 15)
        return lb
    }()

    lazy var idTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "아이디를 입력해주세요"
        tf.autocorrectionType = .no // 자동 수정 활성화 여부
        tf.spellCheckingType = .no // 맞춤법 검사 활성화 여부
        tf.autocapitalizationType = .none // 자동 대문자 활성화 여부
        tf.clearButtonMode = .always // 입력내용 한번에 지우는 x버튼(오른쪽)
        tf.clearsOnBeginEditing = false // 편집 시 기존 텍스트필드값 제거?
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

    lazy var errorMessage: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 15)
        lb.textColor = .red
        return lb
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
        addSubview(appTitle)
        addSubview(appSubTitle)
        addSubview(idPasswodrStack)
        addSubview(loginButton)
        addSubview(makeStack)
        addSubview(errorMessage)
        appTitle.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.top).offset(40)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(50)
        }
        appSubTitle.snp.makeConstraints {
            $0.top.equalTo(appTitle.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        idPasswodrStack.snp.makeConstraints {
            $0.top.equalTo(appSubTitle.snp.top).offset(50)
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
        errorMessage.snp.makeConstraints {
            $0.top.equalTo(idPasswodrStack.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().offset(40)
            $0.height.equalTo(20)
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
