//
//  AddPostViewController.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/26.
//

import FirebaseFirestore
import FirebaseStorage
import UIKit

class AddPostViewController: UIViewController {
    let addPostView = AddPostView()
    let firebaseManager = FirebaseManager()

    var post: Post?
    var isEditingPost = false
    var originalImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view = addPostView
        setupActions()
        setupNavigationBar()
        if let post = post {
            isEditingPost = true
            if let url = URL(string: post.photoURL) {
                addPostView.photoImage.loadImage(from: url) { [weak self] image in
                    self?.originalImage = image // 비동기적으로 원래 이미지를 저장
                }
            }
            addPostView.photoTextfield.text = post.description
        } else {
            addPostView.photoImage.image = UIImage(systemName: "photo")
        }
    }

    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(title: isEditingPost ? "수정" : "추가", style: .plain, target: self, action: #selector(postButtonTapped))
        navigationItem.rightBarButtonItem = rightButton
    }

    private func setupActions() {
        addPostView.addButton.addTarget(self, action: #selector(selectBtnTapped), for: .touchUpInside)
    }

    // 업로드 버튼 클릭시 이벤트
    @objc private func postButtonTapped() {
        print("add 버튼 눌림")
        guard let des = addPostView.photoTextfield.text else { return }
        // firebase에 업로드
        guard let selectedImage = addPostView.photoImage.image else { return }
        guard let userNickname = UserDefaults.standard.nickName else { return }

        // 게시글 수정
        if isEditingPost, let post = post {
            // 사진이 변경되었는지 확인
            if addPostView.photoImage.image == originalImage {
                firebaseManager.updatePost(post: post, newImage: nil, newDescription: des)
            } else {
                firebaseManager.updatePost(post: post, newImage: selectedImage, newDescription: des)
                
            }

        } else {
            // 개시물 추가
            guard let selectedImage = addPostView.photoImage.image else { return }
            firebaseManager.addPost(image: selectedImage, description: des, userId: userNickname)
        }
        navigationController?.popViewController(animated: true)
    }

    // 사진 선택 버튼 클릭시 이벤트
    @objc private func selectBtnTapped() {
        print("갤러리 버튼 눌림")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
}

extension AddPostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 이미지가 선택되었을때 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // 갤러리에서 사진 선택시 이미지뷰 변환
            addPostView.photoImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
