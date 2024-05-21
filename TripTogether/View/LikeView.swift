//
//  LikeView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import SnapKit
import UIKit
class LikeView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var likeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()

    func setupUI() {
        addSubview(likeCollectionView)
        likeCollectionView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(0)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalTo(0)
        }
    }
}
