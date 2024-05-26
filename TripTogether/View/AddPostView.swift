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

    func setupUI() {
        addSubview(photoImage)
        addSubview(photoTextfield)

        photoImage.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        photoTextfield.snp.makeConstraints {
            $0.top.equalTo(photoImage.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
    }
}
