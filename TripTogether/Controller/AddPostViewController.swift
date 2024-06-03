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
    let storage = Storage.storage()
    var post: Post?
    var isEditingPost = false
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view = addPostView
        setupActions()
        setupNavigationBar()
        if let post = post {
            isEditingPost = true
            if let url = URL(string: post.photoURL) {
                addPostView.photoImage.loadImage(from: url)
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

    @objc private func postButtonTapped() {
        print("add 버튼 눌림")
        guard let des = addPostView.photoTextfield.text else { return }
        // firebase에 업로드
        guard let selectedImage = addPostView.photoImage.image else { return }
        guard let userNickname = UserDefaults.standard.nickName else { return }

        if isEditingPost, let post = post {
            updatePost(post: post, newImage: selectedImage, newDescription: des)
        } else {
            addPost(image: selectedImage, description: des, userId: userNickname)
        }
        navigationController?.popViewController(animated: true)
    }

    @objc private func selectBtnTapped() {
        print("add 버튼 눌림")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }

    // Firebase Storage에 사진 업로드
    func uploadImage(_ image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        let storageRef = Storage.storage().reference()
        let imageRef = storageRef.child("images/\(UUID().uuidString).jpg")

        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            completion(.failure(NSError(domain: "ImageConversionError", code: 0, userInfo: nil)))
            return
        }

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"

        imageRef.putData(imageData, metadata: metadata) { _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                } else if let url = url {
                    completion(.success(url.absoluteString))
                }
            }
        }
    }

    // Firestore에 게시글 저장
    func savePostToFirestore(imageUrl: String, description: String, userId: String) {
        let db = Firestore.firestore()
        let postId = UUID().uuidString
        let postData: [String: Any] = [
            "imageUrl": imageUrl,
            "description": description,
            "userId": userId,
            "timestamp": FieldValue.serverTimestamp(),
            "likes": 0,
            "likedBy": []
        ]

        db.collection("posts").document(postId).setData(postData) { error in
            if let error = error {
                print("Error saving post: \(error)")
            } else {
                print("Post successfully saved.")
            }
        }
    }

    // Firestore에서 게시글 수정
    func updatePost(post: Post, newImage: UIImage, newDescription: String) {
        uploadImage(newImage) { result in
            switch result {
            case .success(let imageUrl):
                self.updatePostInFirestore(postId: post.documentId, imageUrl: imageUrl, description: newDescription)
            case .failure(let error):
                print("Error uploading image: \(error)")
            }
        }
    }

    // Firestore에서 게시글 데이터 업데이트
    func updatePostInFirestore(postId: String, imageUrl: String, description: String) {
        let db = Firestore.firestore()
        db.collection("posts").document(postId).updateData([
            "imageUrl": imageUrl,
            "description": description,
            "timestamp": FieldValue.serverTimestamp()
        ]) { error in
            if let error = error {
                print("Error updating post: \(error)")
            } else {
                print("Post successfully updated.")
            }
        }
    }

    // 게시글 저장 함수 호출
    func addPost(image: UIImage, description: String, userId: String) {
        uploadImage(image) { result in
            switch result {
            case .success(let imageUrl):
                self.savePostToFirestore(imageUrl: imageUrl, description: description, userId: userId)
            case .failure(let error):
                print("Error uploading image: \(error)")
            }
        }
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
