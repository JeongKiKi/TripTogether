//
//  MypageView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import SnapKit
import UIKit

class MypageView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var userName: UILabel = {
        let lb = UILabel()
        lb.text = "userName"
        lb.font = .boldSystemFont(ofSize: 20)
        lb.textAlignment = .center
        return lb
    }()

    lazy var myTotalPostInt: UILabel = {
        let lb = UILabel()
        lb.text = "1"
        lb.textColor = .black
        lb.textAlignment = .center
        return lb
    }()

    lazy var myTotalPostLabel: UILabel = {
        let lb = UILabel()
        lb.text = "내 게시물"
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 10)
        lb.textAlignment = .center
        return lb
    }()

    lazy var myTotalLikeInt: UILabel = {
        let lb = UILabel()
        lb.text = "30"
        lb.textColor = .black
        lb.textAlignment = .center
        return lb
    }()

    lazy var myTotalLikeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "받은 총 좋아요"
        lb.textColor = .black
        lb.font = .systemFont(ofSize: 10)
        lb.textAlignment = .center
        return lb
    }()

    lazy var othersTotalLikeInt: UILabel = {
        let lb = UILabel()
        lb.text = "30"
        lb.textColor = .black
        lb.textAlignment = .center
        return lb
    }()

    lazy var othersTotalLikeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "누른 좋아요"
        lb.font = .systemFont(ofSize: 10)
        lb.textColor = .black
        lb.textAlignment = .center
        return lb
    }()

    lazy var myPostStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [myTotalPostInt, myTotalPostLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
        return st
    }()

    lazy var myStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [myTotalLikeInt, myTotalLikeLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
        return st
    }()

    lazy var othersStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [othersTotalLikeInt, othersTotalLikeLabel])
        st.axis = .vertical
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
        return st
    }()

    lazy var likeStack: UIStackView = {
        let st = UIStackView(arrangedSubviews: [myPostStack, myStack, othersStack])
        st.axis = .horizontal
        st.alignment = .fill
        st.distribution = .fillEqually
        st.spacing = 7
        addSubview(st)
        return st
    }()

    lazy var userinfo: UIView = {
        let vw = UIView()
        vw.addSubview(userName)
        vw.addSubview(likeStack)
        vw.backgroundColor = .yellow
        return vw
    }()

    lazy var logoutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("로그아웃", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 5
        btn.layer.borderWidth = 1
        return btn
    }()

    lazy var myPageTableView: UITableView = {
        let table = UITableView()
        return table
    }()
}

extension MypageView {
    func setupUI() {
        addSubview(userinfo)
        addSubview(myPageTableView)
        addSubview(logoutButton)
        userinfo.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(100)
        }
        userName.snp.makeConstraints {
            $0.top.equalTo(userinfo.snp.top).offset(10)
            $0.leading.trailing.equalTo(userinfo)
            $0.height.equalTo(30)
        }
        likeStack.snp.makeConstraints {
            $0.top.equalTo(userName.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(userinfo).inset(20)
            $0.bottom.equalTo(userinfo).offset(-10)
        }
        logoutButton.snp.makeConstraints {
            $0.top.equalTo(userinfo.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(userinfo)
            $0.height.equalTo(30)
        }
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(logoutButton.snp.bottom).offset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalTo(0)
        }
    }
}
