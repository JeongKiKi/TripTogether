//
//  DetailView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/29.
//

import SnapKit
import UIKit
class DetailView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var photoSpot: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()

    lazy var likeButton: UIButton = {
        let btn = UIButton()
        let likeImage = UIImage(systemName: "hand.thumbsup")
        btn.setImage(likeImage, for: .normal)
        btn.tintColor = .blue
        return btn
    }()

    lazy var nickNmaeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "a"
        return lb
    }()

    lazy var descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "a"
        return lb
    }()

    func setupUI() {
        addSubview(photoSpot)
        addSubview(descriptionLabel)
        addSubview(nickNmaeLabel)
        addSubview(likeButton)

        photoSpot.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
            $0.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        likeButton.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.top.equalTo(photoSpot.snp.bottom).offset(5)
            $0.width.height.equalTo(30)
        }
        nickNmaeLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nickNmaeLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }
}
