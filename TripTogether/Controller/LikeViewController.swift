//
//  LikeViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import FirebaseFirestore
import UIKit
class LikeViewController: UIViewController {
    let likeView = LikeView()
    let dummyModel = DummyModel()
    var posts = [Post]()
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Like"
        view = likeView
        // Do any additional setup after loading the view.
        likeView.likeCollectionView.register(LikeCollectionViewCell.self, forCellWithReuseIdentifier: "likeCollectinView")
        likeView.likeCollectionView.delegate = self
        likeView.likeCollectionView.dataSource = self
        fetchPosts()
    }

    private func fetchPosts() {
        db.collection("posts").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap { doc in
                let data = doc.data()
                return Post(documentId: doc.documentID, dictionary: data)
            }
            self.likeView.likeCollectionView.reloadData()
        }
    }
}

extension LikeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "likeCollectinView",
            for: indexPath
        ) as? LikeCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let post = posts[indexPath.row]
        if let url = URL(string: post.photoURL) {
            cell.imageView.loadImage(from: url)
        }
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
