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
        setupActions()
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(postButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    private func setupActions() {
        addPostView.addButton.addTarget(self, action: #selector(selectBtnTapped), for: .touchUpInside)
    }

    @objc private func postButtonTapped() {
        print("add 버튼 눌림")
    }

    @objc private func selectBtnTapped() {
        print("add 버튼 눌림")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            addPostView.photoImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
