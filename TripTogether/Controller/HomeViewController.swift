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
        title = "Home"
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

    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(rightButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc private func rightButtonTapped() {
        print("오른쪽 버튼 눌림")
        let ap = AddPostViewController()
        navigationController?.pushViewController(ap, animated: true)
    }

    private func fetchPosts() {
        db.collection("posts").getDocuments { [weak self] snapshot, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching posts: \(error)")
                return
            }
            guard let documents = snapshot?.documents else { return }
            self.posts = documents.compactMap { Post(dictionary: $0.data()) }
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
        let post = posts[indexPath.row]
        cell.descriptionLabel.text = post.description
        cell.nickNmaeLabel.text = post.userId
        if let url = URL(string: post.photoURL) {
            cell.photoSpot.loadImage(from: url)
        }
        cell.delegate = self
        return cell
    }

    // 좋아요 버튼 클릭시 이벤트
    func didTapLikeButton(in cell: HomeTableViewCell) {
        guard let indexPath = homeView.homeTableView.indexPath(for: cell) else { return }
        let post = posts[indexPath.row]
        print("버튼: \(post.description)")
    }

    // MARK: - UITableViewDelegate

    // 셀 클릭시 이벤트
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        tableView.deselectRow(at: indexPath, animated: true)
        print("버튼눌림 \(indexPath.row)")
        let post = posts[indexPath.row]
        let detailVC = DetailViewController()
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
