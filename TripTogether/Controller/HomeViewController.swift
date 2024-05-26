//
//  MainViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    let dummyModel = DummyModel()
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
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate, HomeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return dummyModel.dummy.count // Example count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        let post = dummyModel.dummy[indexPath.row]
        cell.photoSpot.image = post.photo
        cell.descriptionLabel.text = post.description
        cell.delegate = self
        return cell
    }

    func didTapLikeButton(in cell: HomeTableViewCell) {
        guard let indexPath = homeView.homeTableView.indexPath(for: cell) else { return }
        let post = dummyModel.dummy[indexPath.row]
        print("버튼: \(post.description)")
        // Handle the like action (e.g., update the model, UI, etc.)
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        tableView.deselectRow(at: indexPath, animated: true)
        print("버튼눌림 \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}
