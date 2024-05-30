//
//  Post.swift
//  TripTogether
//
//  Created by 정기현 on 2024/05/28.
//
import Firebase
import FirebaseFirestore

struct Post {
    let photoURL: String
    let description: String
    let userId: String
    let timeStamp: Timestamp
    init(dictionary: [String: Any]) {
        self.photoURL = dictionary["imageUrl"] as? String ?? ""
        self.description = dictionary["description"] as? String ?? ""
        self.userId = dictionary["userId"] as? String ?? ""
        self.timeStamp = dictionary["timestamp"] as? Timestamp ?? Timestamp()
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
