//
//  LikeCollectionViewCell.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/21.
//

import SnapKit
import UIKit

class LikeCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(contentView.snp.width) // Square image
        }
    }
}
