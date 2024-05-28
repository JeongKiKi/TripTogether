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
        guard let des = addPostView.photoTextfield.text else { return }
        // firebase에 업로드
        guard let selectedImage = addPostView.photoImage.image else { return }
        guard let userNickname = UserDefaults.standard.nickName else { return }
        addPost(image: selectedImage, description: des, userId: userNickname)
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
            "timestamp": FieldValue.serverTimestamp()
        ]

        db.collection("posts").document(postId).setData(postData) { error in
            if let error = error {
                print("Error saving post: \(error)")
            } else {
                print("Post successfully saved.")
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
