//
//  MainView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import SnapKit
import UIKit
class HomeView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var homeTableView: UITableView = {
        let table = UITableView()
        return table
    }()

    func setupUI() {
        addSubview(homeTableView)
        homeTableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalTo(0)
        }
    }
}
