//
//  MypageViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import FirebaseFirestore
import FirebaseStorage
import UIKit

class MypageViewController: UIViewController {
    let mypageView = MypageView()
    let dummyModel = DummyModel()
    let loginCheck = LoginCheck()
    var posts = [Post]()
    let db = Firestore.firestore()
    let storage = Storage.storage()
    let loginUid = UserDefaults.standard.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "MyPage"
        view = mypageView

        mypageView.myPageTableView.register(MypageTableViewCell.self, forCellReuseIdentifier: "MyPageCell")
        mypageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        mypageView.myPageTableView.dataSource = self
        mypageView.myPageTableView.delegate = self
        mypageView.myTotalPostInt.text = "\(posts.count)"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPosts()
        fetchUserDatas(uid: loginUid)
        guard let userNickname = UserDefaults.standard.nickName else { return }
        guard let like = UserDefaults.standard.like else { return }
        var liked = 0
        for i in posts {
            liked += i.likes
        }

        // Ensure the nickname is updated before the view appears
        mypageView.userName.text = userNickname
        mypageView.myTotalLikeInt.text = String(liked)
        mypageView.othersTotalLikeInt.text = String(like.count)
        mypageView.myTotalPostInt.text = "\(posts.count)"
    }

    @objc private func logoutButtonTapped() {
        UserDefaults.standard.isLoggedIn = false
        print("logoutnbtn")
        loginCheck.switchToLoginViewController()
    }

    override func loadView() {
        super.loadView()
        fetchPosts()
    }

    // 변경된 정보를 uid를 통해 유저 정보불러와 유저디폴트로 저장
    private func fetchUserDatas(uid: String?) {
        guard let uid = uid else { return }
        db.collection("userInfo").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists,
                  let data = document.data(),
                  let nickName = data["nickName"] as? String,
                  let like = data["like"] as? [String],
                  let liked = data["liked"] as? [String]
            else {
                print("User data not found or malformed")
                return
            }

            UserDefaults.standard.uid = uid
            UserDefaults.standard.nickName = nickName
            UserDefaults.standard.like = like
            UserDefaults.standard.liked = liked
        }
    }

    // 로그인된 유저의 게시물을 가져옴
    private func fetchPosts() {
        guard let nickname = UserDefaults.standard.string(forKey: "nickName") else { return }

        db.collection("posts")
            .whereField("userId", isEqualTo: nickname)
            .getDocuments { [weak self] snapshot, error in
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
                self.mypageView.myPageTableView.reloadData()
                mypageView.myTotalPostInt.text = "\(posts.count)"
            }
    }
}

extension MypageViewController: UITableViewDataSource, UITableViewDelegate, MypageTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as? MypageTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        if let url = URL(string: post.photoURL) {
            cell.myPhotoSpot.loadImage(from: url) { [weak self] _ in
                // 필요 시 이미지 로드 완료 후 추가 작업 수행
            }
        }
        cell.myDescriptionLabel.text = post.description
        cell.delegate = self
        return cell
    }

    func didTapLikeButton(in cell: MypageTableViewCell) {
        guard let indexPath = mypageView.myPageTableView.indexPath(for: cell) else { return }
        let post = posts[indexPath.row]
        print("버튼: \(post.description)")
        // Handle the like action (e.g., update the model, UI, etc.)
    }

    func optionButtonTapped(in cell: MypageTableViewCell) {
        guard let indexPath = mypageView.myPageTableView.indexPath(for: cell) else { return }
        let post = posts[indexPath.row]

        let alertController = UIAlertController(title: "옵션", message: "선택하세요", preferredStyle: .actionSheet)

        let editAction = UIAlertAction(title: "수정", style: .default) { _ in
            print("수정 버튼 눌림: \(post.description)")
            // 수정 기능 구현
            let ad = AddPostViewController()
            ad.post = post
            ad.isEditingPost = true
            self.navigationController?.pushViewController(ad, animated: true)
        }

        let deleteAction = UIAlertAction(title: "삭제", style: .destructive) { _ in
            print("삭제 버튼 눌림: \(post.description)")
            self.deletePost(post, at: indexPath)
        }

        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소 버튼 눌림")
        }

        alertController.addAction(editAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }

    // 게시물 삭제(사진삭제 -> 문서삭제 -> 해당 게시물 좋아요 누른 유저 좋아요 제거)
    func deletePost(_ post: Post, at indexPath: IndexPath) {
        let storageRef = storage.reference(forURL: post.photoURL)
        // Storage에서 사진 삭제
        storageRef.delete { [weak self] error in
            if let error = error {
                print("Error deleting image: \(error)")
                return
            }
            print("Image deleted successfully")

            // Firestore 트랜잭션 시작
            self?.db.runTransaction({ transaction, _ -> Any? in
                let postRef = self?.db.collection("posts").document(post.documentId)

                // 문서 삭제
                transaction.deleteDocument(postRef!)

                // 좋아요 누른 유저들의 userInfo 업데이트
                for userId in post.likedBy {
                    let userLikeRef = self?.db.collection("userInfo").document(userId)
                    userLikeRef?.updateData([
                        "like": FieldValue.arrayRemove([post.documentId])
                    ])
                }

                return nil
            }, completion: { [weak self] _, error in
                if let error = error {
                    print("Transaction failed: \(error)")
                } else {
                    print("Transaction successfully committed!")
                    self?.posts.remove(at: indexPath.row)
                    self?.mypageView.myPageTableView.deleteRows(at: [indexPath], with: .automatic)
                    self?.mypageView.myTotalPostInt.text = "\(self?.posts.count ?? 0)"
                }
            })
        }
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
