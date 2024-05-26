//
//  AddPostViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/26.
//

import UIKit

class AddPostViewController: UIViewController {
    
    let addPostView = AddPostView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view = addPostView
    }
}
