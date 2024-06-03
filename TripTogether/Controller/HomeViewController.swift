//
//  MainViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import Firebase
import FirebaseFirestore
import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    let dummyModel = DummyModel()
    var posts = [Post]()
    let db = Firestore.firestore()

    override func viewDidLoad() {
        title = "TripTogether"
        super.viewDidLoad()
        view.backgroundColor = .white
        view = homeView
        // Do any additional setup after loading the view.
        homeView.homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        homeView.homeTableView.dataSource = self
        homeView.homeTableView.delegate = self
        setupNavigationBar()
        fetchPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPosts()
    }

    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc private func rightButtonTapped() {
        print("오른쪽 버튼 눌림")
        let ap = AddPostViewController()
        ap.isEditingPost = false
        navigationController?.pushViewController(ap, animated: true)
    }

    private func fetchPosts() {
        // 업로드한 최신순으로 나열
        db.collection("posts").order(by: "timestamp", descending: true).getDocuments { [weak self] snapshot, error in
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
            self.homeView.homeTableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, HomeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return posts.count
    }

    // 셀 구성
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let userId = UserDefaults.standard.uid ?? ""

        let post = posts[indexPath.row]
        let updatedLikedBy = post.likedBy
        var likedImages = UIImage(systemName: "hand.thumbsup.fill")
        // 사용자가 이미 좋아요를 했는지 확인
        if updatedLikedBy.contains(userId) {
            // 이미 좋아요를 한 경우: 좋아요 취소
            likedImages = UIImage(systemName: "hand.thumbsup.fill")
        } else {
            // 좋아요를 하지 않은 경우: 좋아요 추가
            likedImages = UIImage(systemName: "hand.thumbsup")
        }
        cell.descriptionLabel.text = post.description
        cell.nickNmaeLabel.text = post.userId
        cell.likeButton.setImage(likedImages, for: .normal)
        if let url = URL(string: post.photoURL) {
            cell.photoSpot.loadImage(from: url)
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:mm"

        let date = post.timeStamp.dateValue()
        cell.timeLabel.text = dateFormatter.string(from: date)
        cell.delegate = self
        return cell
    }

    // 좋아요 버튼 클릭시 이벤트
    func didTapLikeButton(in cell: HomeTableViewCell) {
        guard let indexPath = homeView.homeTableView.indexPath(for: cell) else { return }
        let post = posts[indexPath.row]
        print("버튼: \(post.description)")
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
            self?.posts[indexPath.row].likes = updatedLikes
            self?.posts[indexPath.row].likedBy = updatedLikedBy
            cell.likeButton.setImage(likedImages, for: .normal)
            self?.homeView.homeTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - UITableViewDelegate

    // 셀 클릭시 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        tableView.deselectRow(at: indexPath, animated: true)
        print("버튼눌림 \(indexPath.row)")
        let post = posts[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.post = post
        detailVC.photos = post.photoURL
        detailVC.userId = post.userId
        detailVC.descriptions = post.description
        navigationController?.pushViewController(detailVC, animated: true)
    }

    // 셀 높이 설정
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
