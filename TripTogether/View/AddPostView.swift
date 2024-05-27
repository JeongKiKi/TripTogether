//
//  AddPostView.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/26.
//

import SnapKit
import UIKit

class AddPostView: UIView {
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var photoImage: UIImageView = {
        let imgView = UIImageView()
        imgView.image = .actions
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()

    lazy var photoTextfield: UITextField = {
        let tf = UITextField()
        tf.placeholder = "aaaa"
        return tf
    }()

    lazy var addButton: UIButton = {
        let btn = UIButton()
        btn.setImage(.add, for: .normal)
//        btn.setTitleColor(.white, for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .black
        btn.layer.cornerRadius = 10
        return btn
    }()

    func setupUI() {
        addSubview(photoImage)
        addSubview(photoTextfield)
        addSubview(addButton)
        photoImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        addButton.snp.makeConstraints {
            $0.top.equalTo(photoImage.snp.top).offset(10)
            $0.trailing.equalTo(photoImage.snp.trailing).offset(10)
            $0.width.height.equalTo(20)
        }
        photoTextfield.snp.makeConstraints {
            $0.top.equalTo(photoImage.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
}
