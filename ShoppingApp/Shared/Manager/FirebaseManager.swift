//
//  FirebaseManager.swift
//  ShoppingAppAdmin
//
//  Created by Rami Mustafa on 04.08.24.
//
import UIKit
import FirebaseStorage
import FirebaseFirestore



class FirebaseManager {
    
    static let shared = FirebaseManager()
    private init() {}
    
    func checkCategoryExists(categoryName: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        let query = db.collection("categories").whereField("name", isEqualTo: categoryName)

        query.getDocuments { (snapshot, error) in
            if let error = error {
                print("Error checking category: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let snapshot = snapshot, snapshot.documents.count > 0 {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func uploadCategoryImageAndDocument(image: UIImage, categoryName: String, categoryToEdit: Category?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            completion(.failure(NSError(domain: "FirebaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }
        
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(NSError(domain: "FirebaseManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "URL is nil"])))
                    return
                }
                
                self.uploadCategoryDocument(url: url.absoluteString, categoryName: categoryName, categoryToEdit: categoryToEdit) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }
    
    private func uploadCategoryDocument(url: String, categoryName: String, categoryToEdit: Category?, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var docRef: DocumentReference!
        var category = Category(name: categoryName, id: "", imgUrl: url, timeStamp: Timestamp())
        
        if let categoryToEdit = categoryToEdit {
            docRef = db.collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            docRef = db.collection("categories").document()
            category.id = docRef.documentID
        }
        
        let data = Category.modelToData(category: category)
        
        docRef.setData(data, merge: true) { error in
            completion(error)
        }
    }
    
    func uploadProductImageAndDocument(image: UIImage, productName: String, selectedCategory: Category, productToEdit: Product?, description: String, price: Double, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            completion(.failure(NSError(domain: "FirebaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }
        
        let imageRef = Storage.storage().reference().child("/productImages/\(productName).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(NSError(domain: "FirebaseManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "URL is nil"])))
                    return
                }
                
                self.uploadProductDocument(url: url.absoluteString, productName: productName, selectedCategory: selectedCategory, productToEdit: productToEdit, description: description, price: price) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }
    
    private func uploadProductDocument(url: String, productName: String, selectedCategory: Category, productToEdit: Product?, description: String, price: Double, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var docRef: DocumentReference!
        var product = Product(name: productName, id: "", category: selectedCategory.id, price: price, productDescription: description, imageUrl: url)
        
        if let productToEdit = productToEdit {
            docRef = db.collection("products").document(productToEdit.id)
            product.id = productToEdit.id
        } else {
            docRef = db.collection("products").document()
            product.id = docRef.documentID
        }
        
        let data = Product.modelToData(product: product)
        
        docRef.setData(data, merge: true) { error in
            completion(error)
        }
    }
}


/*
class FirebaseManager {
    
    static let shared = FirebaseManager()
    private init() {}
    
    
    func checkCategoryExists(categoryName: String, completion: @escaping (Bool) -> Void) {
          let db = Firestore.firestore()
          let query = db.collection("categories").whereField("name", isEqualTo: categoryName)

          query.getDocuments { (snapshot, error) in
              if let error = error {
                  print("Error checking category: \(error.localizedDescription)")
                  completion(false)
                  return
              }
              
              if let snapshot = snapshot, snapshot.documents.count > 0 {
                  // Category already exists
                  completion(true)
              } else {
                  // Category does not exist
                  completion(false)
              }
          }
      }
    
    
    // Function to upload image to Firebase Storage and then upload document data
    func uploadCategoryImageAndDocument(image: UIImage, categoryName: String, categoryToEdit: Category?, completion: @escaping (Result<String, Error>) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.2) else {
            completion(.failure(NSError(domain: "FirebaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
            return
        }
        
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { metadata, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            imageRef.downloadURL { url, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let url = url else {
                    completion(.failure(NSError(domain: "FirebaseManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "URL is nil"])))
                    return
                }
                
                self.uploadCategoryDocument(url: url.absoluteString, categoryName: categoryName, categoryToEdit: categoryToEdit) { error in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(url.absoluteString))
                    }
                }
            }
        }
    }
    
    private func uploadCategoryDocument(url: String, categoryName: String, categoryToEdit: Category?, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        var docRef: DocumentReference!
        var category = Category(name: categoryName, id: "", imgUrl: url, timeStamp: Timestamp())
        
        if let categoryToEdit = categoryToEdit {
            docRef = db.collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            docRef = db.collection("categories").document()
            category.id = docRef.documentID
        }
        
        let data = Category.modelToData(category: category)
        
        docRef.setData(data, merge: true) { error in
            completion(error)
        }
    }
    
    
    // Function to upload product image to Firebase Storage and then upload product document data
    func uploadProductImageAndDocument(image: UIImage, productName: String, selectedCategory: Category, productToEdit: Product?, description: String, price: Double, completion: @escaping (Result<String, Error>) -> Void) {
         guard let imageData = image.jpegData(compressionQuality: 0.2) else {
             completion(.failure(NSError(domain: "FirebaseManager", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid image data"])))
             return
         }
         
         let imageRef = Storage.storage().reference().child("/productImages/\(productName).jpg")
         let metaData = StorageMetadata()
         metaData.contentType = "image/jpg"
         
         imageRef.putData(imageData, metadata: metaData) { metadata, error in
             if let error = error {
                 completion(.failure(error))
                 return
             }
             
             imageRef.downloadURL { url, error in
                 if let error = error {
                     completion(.failure(error))
                     return
                 }
                 
                 guard let url = url else {
                     completion(.failure(NSError(domain: "FirebaseManager", code: -2, userInfo: [NSLocalizedDescriptionKey: "URL is nil"])))
                     return
                 }
                 
                 self.uploadProductDocument(url: url.absoluteString, productName: productName, selectedCategory: selectedCategory, productToEdit: productToEdit, description: description, price: price) { error in
                     if let error = error {
                         completion(.failure(error))
                     } else {
                         completion(.success(url.absoluteString))
                     }
                 }
             }
         }
     }
    
    
    private func uploadProductDocument(url: String, productName: String, selectedCategory: Category, productToEdit: Product?, description: String, price: Double, completion: @escaping (Error?) -> Void) {
         let db = Firestore.firestore()
         var docRef: DocumentReference!
         var product = Product(name: productName, id: "", category: selectedCategory.id, price: price, productDescription: description, imageUrl: url)
         
         if let productToEdit = productToEdit {
             docRef = db.collection("products").document(productToEdit.id)
             product.id = productToEdit.id
         } else {
             docRef = db.collection("products").document()
             product.id = docRef.documentID
         }
         
         let data = Product.modelToData(product: product)
         
         docRef.setData(data, merge: true) { error in
             completion(error)
         }
     }
}
*/
