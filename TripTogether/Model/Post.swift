//
//  Post.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/28.
//
import Firebase
import FirebaseFirestore

struct Post {
    let documentId: String
    let photoURL: String
    let description: String
    let userId: String
    let timeStamp: Timestamp
    var likes: Int
    var likedBy: [String]
    init(documentId: String, dictionary: [String: Any]) {
        self.documentId = documentId
        self.photoURL = dictionary["imageUrl"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        self.timeStamp = dictionary["timestamp"] as? Timestamp ?? Timestamp()
        self.likes = dictionary["likes"] as? Int ?? 0
        self.likedBy = dictionary["likedBy"] as? [String] ?? []
    }
}
//기존
//extension UIImageView {
//    func loadImage(from url: URL) {
//        DispatchQueue.global().async { [weak self] in
//            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self?.image = image
//                }
//            }
//        }
//    }
//}
//이미지 저장을 위한 새로운 코드
extension UIImageView {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
