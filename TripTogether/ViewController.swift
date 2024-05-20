//
//  ViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/20.
//

import SnapKit
import UIKit
class ViewController: UIViewController {
    let loginView = LoginView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func loadView() {
        super.loadView()
        view = loginView
    }
}
