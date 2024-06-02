//
//  DetailViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/29.
//
import Firebase
import FirebaseFirestore
import UIKit

class DetailViewController: UIViewController {
    let db = Firestore.firestore()
    let detailView = DetailView()
    var post: Post?
    var photos: String?
    var descriptions: String?
    var userId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        receiveInfo()
        btnsetting()
    }

    func btnsetting() {
        detailView.likeButton.addTarget(self, action: #selector(likeBtnTap), for: .touchUpInside)
        updateLikeButton()
    }

    private func updateLikeButton() {
        guard let updatedLikedBy = post?.likedBy else { return }
        guard let uid = UserDefaults.standard.uid else { return }
        var likedImage: UIImage?

        if updatedLikedBy.contains(uid) {
            likedImage = UIImage(systemName: "hand.thumbsup.fill")
        } else {
            likedImage = UIImage(systemName: "hand.thumbsup")
        }

        detailView.likeButton.setImage(likedImage, for: .normal)
    }

    @objc func likeBtnTap() {
        print("Aa")
        guard let post = post else { return }
        // 현재 사용자의 ID 가져오기
        guard let userId = UserDefaults.standard.uid else { return }
        var userLikes = UserDefaults.standard.like ?? []
        var updatedLikes = post.likes
        var updatedLikedBy = post.likedBy
        var likedImages = UIImage(systemName: "hand.thumbsup.fill")
        // 사용자가 이미 좋아요를 했는지 확인
        if updatedLikedBy.contains(userId) {
            // 이미 좋아요를 한 경우: 좋아요 취소
            updatedLikes -= 1
            updatedLikedBy.removeAll { $0 == userId }
            likedImages = UIImage(systemName: "hand.thumbsup.fill")

            // 좋아요 배열에서 해당 포스트 ID 제거
            let userLikeRef = db.collection("userInfo").document(userId)
            userLikeRef.updateData([
                "like": FieldValue.arrayRemove([post.documentId])
            ])
            userLikes.removeAll { $0 == post.documentId }
        } else {
            // 좋아요를 하지 않은 경우: 좋아요 추가
            updatedLikes += 1
            updatedLikedBy.append(userId)
            likedImages = UIImage(systemName: "hand.thumbsup")

            // 좋아요 배열에 해당 포스트 ID 추가
            let userLikeRef = db.collection("userInfo").document(userId)
            userLikeRef.updateData([
                "like": FieldValue.arrayUnion([post.documentId])
            ])
            // 좋아요 배열에 해당 포스트 ID 추가
            userLikes.append(post.documentId)
        }
        UserDefaults.standard.like = userLikes
        // Firebase에 좋아요 정보 업데이트
        let postRef = db.collection("posts").document(post.documentId)
        postRef.updateData([
            "likes": updatedLikes,
            "likedBy": updatedLikedBy
        ]) { [weak self] error in
            if let error = error {
                print("Error updating likes: \(error)")
                return
            }
            // 로컬 데이터 업데이트 및 테이블 뷰 새로 고침
            self?.post?.likes = updatedLikes
            self?.post?.likedBy = updatedLikedBy
            self?.updateLikeButton()
        }
    }

    func receiveInfo() {
        detailView.nickNmaeLabel.text = userId
        detailView.descriptionLabel.text = descriptions
        guard let photos = photos else { return }
        if let url = URL(string: photos) {
            detailView.photoSpot.loadImage(from: url)
        }
    }
}
