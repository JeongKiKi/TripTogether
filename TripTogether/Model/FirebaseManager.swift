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
}
