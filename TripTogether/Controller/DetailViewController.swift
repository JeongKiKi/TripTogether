//
//  DetailViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/29.
//

import UIKit

class DetailViewController: UIViewController {
    let detailView = DetailView()
    var photos: String?
    var descriptions: String?
    var userId: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view = detailView
        receiveInfo()
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
