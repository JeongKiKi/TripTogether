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

// 이미지를 캐싱하기 위한 싱글톤 클래스를 정의
enum ImageCache {
    static let shared = NSCache<NSString, UIImage>()
}

extension UIImageView {
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        // 캐시된 이미지가 있는지 확인
        if let cachedImage = ImageCache.shared.object(forKey: url.absoluteString as NSString) {
            self.image = cachedImage
            completion(cachedImage)
            return
        }
        // 비동기적으로 이미지를 다운로드
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                // 캐시에 저장
                ImageCache.shared.setObject(image, forKey: url.absoluteString as NSString)
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
    // 이미지 URL을 새로 설정하고 업데이트하는 메서드
        func updateImage(from newUrl: URL, completion: @escaping (UIImage?) -> Void) {
            // 기존 URL의 캐시 제거
            ImageCache.shared.removeObject(forKey: newUrl.absoluteString as NSString)
            
            // 비동기적으로 새 이미지 다운로드
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: newUrl), let image = UIImage(data: data) {
                    // 다운로드된 이미지를 캐시에 저장
                    ImageCache.shared.setObject(image, forKey: newUrl.absoluteString as NSString)
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
