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
    var posts = [Post]()
    let db = Firestore.firestore()
    var firebaseManager = FirebaseManager()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        title = "TripTogether"
        super.viewDidLoad()
        view.backgroundColor = .white
        view = homeView

        homeView.homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        homeView.homeTableView.dataSource = self
        homeView.homeTableView.delegate = self

        // 새로고침 컨트롤러 설정
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        homeView.homeTableView.refreshControl = refreshControl

        setupNavigationBar()
        fetchPosts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPosts()
    }

    // 네비게이션바 셋팅
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    // 게시물 새로고침 함수
    @objc private func refreshPosts() {
        print("새로고침")
        fetchPosts {
            self.refreshControl.endRefreshing()
        }
    }

    @objc private func rightButtonTapped() {
        print("오른쪽 버튼 눌림")
        let ap = AddPostViewController()
        ap.isEditingPost = false
        navigationController?.pushViewController(ap, animated: true)
    }

    // 게시물 데이터 가져오는 함수
    private func fetchPosts(completion: (() -> Void)? = nil) {
        firebaseManager.fetchPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let posts):
                self.posts = posts
                self.homeView.homeTableView.reloadData()
                completion?()
            case .failure(let error):
                print("Error fetching posts: \(error)")
                completion?()
            }
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
            cell.photoSpot.loadImage(from: url) { [weak self] _ in
                // 필요 시 이미지 로드 완료 후 추가 작업 수행
            }
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
        guard let userId = UserDefaults.standard.uid else { return }

        firebaseManager.updateLikeStatus(for: post, userId: userId) { [weak self] updatedLikes, updatedLikedBy, error in
            if let error = error {
                print("Error updating likes: \(error)")
                return
            }
            // 로컬 데이터 업데이트 및 테이블 뷰 새로 고침
            self?.posts[indexPath.row].likes = updatedLikes
            self?.posts[indexPath.row].likedBy = updatedLikedBy
            let likedImage = updatedLikedBy.contains(userId) ? UIImage(systemName: "hand.thumbsup.fill") : UIImage(systemName: "hand.thumbsup")
            cell.likeButton.setImage(likedImage, for: .normal)
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
