//
//  MypageViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import UIKit

class MypageViewController: UIViewController {
    let mypageView = MypageView()
    let dummyModel = DummyModel()
    let loginCheck = LoginCheck()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "MyPage"
        view = mypageView
        mypageView.myPageTableView.register(MypageTableViewCell.self, forCellReuseIdentifier: "MyPageCell")
        mypageView.logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)

        mypageView.myPageTableView.dataSource = self
        mypageView.myPageTableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let userNickname = UserDefaults.standard.nickName else { return }
        guard let like = UserDefaults.standard.like else { return }
        guard let liked = UserDefaults.standard.liked else { return }

        print(userNickname)
        // Ensure the nickname is updated before the view appears
        mypageView.userName.text = UserDefaults.standard.nickName
        mypageView.myTotalLikeInt.text = UserDefaults.standard.like
        mypageView.othersTotalLikeInt.text = UserDefaults.standard.liked
    }

    @objc private func logoutButtonTapped() {
        UserDefaults.standard.isLoggedIn = false
        print("logoutnbtn")
        loginCheck.switchToLoginViewController()
    }

    override func loadView() {
        super.loadView()
    }
}

extension MypageViewController: UITableViewDataSource, UITableViewDelegate, MypageTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyModel.dummy.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyPageCell", for: indexPath) as? MypageTableViewCell else {
            return UITableViewCell()
        }
        let post = dummyModel.dummy[indexPath.row]
        cell.myPhotoSpot.image = post.photo
        cell.myDescriptionLabel.text = post.description
        cell.delegate = self
        return cell
    }

    func didTapOptionButton(in cell: MypageTableViewCell) {
        guard let indexPath = mypageView.myPageTableView.indexPath(for: cell) else { return }
        let post = dummyModel.dummy[indexPath.row]
        print("버튼: \(post.description)")
        // Handle the like action (e.g., update the model, UI, etc.)
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
