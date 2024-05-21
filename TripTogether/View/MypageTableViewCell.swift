//
//  MypageTableViewCell.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/21.
//

import SnapKit
import UIKit

protocol MypageTableViewCellDelegate: AnyObject {
    func didTapOptionButton(in cell: MypageTableViewCell)
}

class MypageTableViewCell: UITableViewCell {
    weak var delegate: MypageTableViewCellDelegate?

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

    lazy var myPhotoSpot: UIImageView = {
        let im = UIImageView()
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()

    lazy var optionButton: UIButton = {
        let btn = UIButton()
        let likeImage = UIImage(systemName: "hand.thumbsup")
        btn.setImage(likeImage, for: .normal)
        btn.tintColor = .blue
        btn.addTarget(self, action: #selector(optionButtonTapped), for: .touchUpInside)
        return btn
    }()

    lazy var myDescriptionLabel: UILabel = {
        let lb = UILabel()
        lb.text = "a"
        return lb
    }()

    func setupUI() {
        contentView.addSubview(myPhotoSpot)
        contentView.addSubview(myDescriptionLabel)
        contentView.addSubview(optionButton)

        myPhotoSpot.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
            make.bottom.lessThanOrEqualToSuperview().offset(-10) // Ensure the bottom margin is respected
        }
        optionButton.snp.makeConstraints {
            $0.leading.equalTo(myDescriptionLabel.snp.leading)
            $0.top.equalTo(myPhotoSpot.snp.bottom).offset(5)
            $0.width.height.equalTo(30)
        }
        myDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(optionButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(30)
            make.bottom.lessThanOrEqualToSuperview().offset(-10)
        }
    }

    @objc func optionButtonTapped() {
        delegate?.didTapOptionButton(in: self)
    }
}
