//
//  MypageViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import FirebaseFirestore
import UIKit
class MypageViewController: UIViewController {
    let mypageView = MypageView()
    let dummyModel = DummyModel()
    let loginCheck = LoginCheck()
    var posts = [Post]()
    let db = Firestore.firestore()

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
        guard let userNickname = UserDefaults.standard.nickName else { return }
        guard let like = UserDefaults.standard.like else { return }
        guard let liked = UserDefaults.standard.liked else { return }

        // Ensure the nickname is updated before the view appears
        mypageView.userName.text = userNickname
        mypageView.myTotalLikeInt.text = like
        mypageView.othersTotalLikeInt.text = liked
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
            cell.myPhotoSpot.loadImage(from: url)
        }
        cell.myDescriptionLabel.text = post.description
        cell.delegate = self
        return cell
    }

    func didTapOptionButton(in cell: MypageTableViewCell) {
        guard let indexPath = mypageView.myPageTableView.indexPath(for: cell) else { return }
        let post = posts[indexPath.row]
        print("버튼: \(post.description)")
        // Handle the like action (e.g., update the model, UI, etc.)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
