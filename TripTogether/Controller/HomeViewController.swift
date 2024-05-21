//
//  MainViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    override func viewDidLoad() {
        title = "Home"
        super.viewDidLoad()
        view.backgroundColor = .white
        view = homeView
        // Do any additional setup after loading the view.
        homeView.homeTableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        homeView.homeTableView.dataSource = self
        homeView.homeTableView.delegate = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section
        return 10 // Example count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        // Configure the cell
        cell.textLabel?.text = "Row \(indexPath.row)" // Example text
        return cell
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle row selection
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
