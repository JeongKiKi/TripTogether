//
//  HomeTableViewCell.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/21.
//

import SnapKit
import UIKit

protocol HomeTableViewCellDelegate: AnyObject {
    func didTapLikeButton(in cell: HomeTableViewCell)
}

class HomeTableViewCell: UITableViewCell {
    weak var delegate: HomeTableViewCellDelegate?
    let homeView = HomeView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(homeView)
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
        btn.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        return btn
    }()

    lazy var nickNmaeLabel: UILabel = {
        let lb = UILabel()
        lb.text = "a"
        return lb
    }()

    lazy var timeLabel: UILabel = {
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
        contentView.addSubview(photoSpot)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(nickNmaeLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(likeButton)

        photoSpot.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // Ensure the bottom margin is respected
        }
        likeButton.snp.makeConstraints {
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.top.equalTo(photoSpot.snp.bottom).offset(5)
            $0.width.height.equalTo(30)
        }
        nickNmaeLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.trailing.equalTo(photoSpot.snp.trailing)
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

    @objc func likeButtonTapped() {
        delegate?.didTapLikeButton(in: self)
    }
}
