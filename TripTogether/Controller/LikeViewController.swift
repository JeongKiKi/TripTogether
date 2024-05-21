//
//  LikeViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import UIKit

class LikeViewController: UIViewController {
    let likeView = LikeView()
    let dummyModel = DummyModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Like"
        view = likeView
        // Do any additional setup after loading the view.
        likeView.likeCollectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: "likeCollectinView")
        likeView.likeCollectionView.delegate = self
        likeView.likeCollectionView.dataSource = self
    }
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyModel.dummy.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "likeCollectinView",
            for: indexPath
        ) as? LikeCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let post = dummyModel.dummy[indexPath.row]
        cell.imageView.image = post.photo
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let a = (view.bounds.width - 4) / 3
        return CGSize(width: a, height: a)
    }
}

extension LikeViewController: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 2
    }

    // 옆 간격
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 2
    }
}
