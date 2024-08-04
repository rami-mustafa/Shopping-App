//
//  FirebaseManager.swift
//  ShoppingAppAdmin
//
//  Created by Rami Mustafa on 04.08.24.
//

 
import UIKit
import FirebaseStorage

class FirebaseManager {
    
    static let shared = FirebaseManager()
    private let storageRef = Storage.storage().reference() 
    
    private init() {}

    
    func uploadImage(image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            completion(.failure(NSError(domain: "FirebaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }
        
        let uniqueImageFileName = "/categoryImages"
        let imageRef = storageRef.child(uniqueImageFileName)
        
        imageRef.putData(imageData, metadata: nil) { metadata, error in
            guard metadata != nil else {
                completion(.failure(error ?? NSError(domain: "FirebaseManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "Failed to upload image"])))
                return
            }
            
            imageRef.downloadURL { url, error in
                guard let downloadURL = url else {
                    completion(.failure(error ?? NSError(domain: "FirebaseManager", code: -3, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch download URL"])))
                    return
                }
                
                completion(.success(downloadURL.absoluteString))
            }
        }
    }
    
    
    func downloadImage(fromURL urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let url = URL(string: urlString)!
        let imageRef = Storage.storage().reference(forURL: urlString)
        
        imageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(NSError(domain: "FirebaseManager", code: -4, userInfo: [NSLocalizedDescriptionKey: "Data is corrupt or missing"])))
            }
        }
    }
}
