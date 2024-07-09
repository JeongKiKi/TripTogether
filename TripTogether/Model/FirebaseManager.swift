//
//  FirebaseManager.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/24.
//

import FirebaseAuth
import FirebaseFirestore
import UIKit

class FirebaseManager {
    let db = Firestore.firestore()
    private let auth = Auth.auth()
    let loginCheck = LoginCheck()

    // uid를 통해 유저 정보불러와 유저디폴트로 저장
    // 로그인 시도시 사용
    func fetchUserData(uid: String) {
        db.collection("userInfo").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                return
            }

            guard let document = document, document.exists,
                  let data = document.data(),
                  let nickName = data["nickName"] as? String,
                  let like = data["like"] as? [String],
                  let liked = data["liked"] as? [String]
            else {
                print("User data not found or malformed")
                return
            }

            UserDefaults.standard.isLoggedIn = true
            UserDefaults.standard.uid = uid
            UserDefaults.standard.nickName = nickName
            UserDefaults.standard.like = like
            UserDefaults.standard.liked = liked
            self.loginCheck.switchToMainTabBarController()
        }
    }

    // 이메일과 비밀번호를 사용하여 로그인
    func loginUser(withEmail email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let uid = authResult?.user.uid else {
                completion(.failure(NSError(domain: "LoginError", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID not found"])))
                return
            }

            completion(.success(uid))
        }
    }

    // 회원가입 메서드 추가
    func registerUser(withEmail email: String, password: String, nickname: String, completion: @escaping (Result<String, Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let uid = authResult?.user.uid else {
                completion(.failure(NSError(domain: "RegistrationError", code: 0, userInfo: [NSLocalizedDescriptionKey: "UID not found"])))
                return
            }

            self.db.collection("userInfo").document(uid).setData([
                "email": email,
                "nickName": nickname,
                "like": [],
                "liked": [],
                "uid": uid
            ]) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
                    completion(.success(uid))
                }
            }
        }
    }

    func resetPassword(withEmail email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }
    }

    // 게시물 데이터 가져오기 메서드 추가
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> Void) {
        db.collection("posts").order(by: "timestamp", descending: true).getDocuments { snapshot, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let documents = snapshot?.documents else {
                completion(.success([]))
                return
            }
            let posts = documents.compactMap { doc in
                let data = doc.data()
                return Post(documentId: doc.documentID, dictionary: data)
            }
            completion(.success(posts))
        }
    }

    // 좋아요 상태 업데이트 메서드 추가
    func updateLikeStatus(for post: Post, userId: String, completion: @escaping (Int, [String], Error?) -> Void) {
        var updatedLikes = post.likes
        var updatedLikedBy = post.likedBy
        var userLikes = UserDefaults.standard.like ?? []

        // 사용자가 이미 좋아요를 했는지 확인
        if updatedLikedBy.contains(userId) {
            // 이미 좋아요를 한 경우: 좋아요 취소
            updatedLikes -= 1
            updatedLikedBy.removeAll { $0 == userId }
            userLikes.removeAll { $0 == post.documentId }

            let userLikeRef = db.collection("userInfo").document(userId)
            userLikeRef.updateData([
                "like": FieldValue.arrayRemove([post.documentId])
            ])
        } else {
            // 좋아요를 하지 않은 경우: 좋아요 추가
            updatedLikes += 1
            updatedLikedBy.append(userId)
            userLikes.append(post.documentId)

            let userLikeRef = db.collection("userInfo").document(userId)
            userLikeRef.updateData([
                "like": FieldValue.arrayUnion([post.documentId])
            ])
        }

        UserDefaults.standard.like = userLikes

        let postRef = db.collection("posts").document(post.documentId)
        postRef.updateData([
            "likes": updatedLikes,
            "likedBy": updatedLikedBy
        ]) { error in
            completion(updatedLikes, updatedLikedBy, error)
        }
    }
}
