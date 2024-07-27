//
//  NetworkManager.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//


/*
import Foundation

enum URLs: String {
    case baseUrl = "https://fakestoreapi.com"
    case login = "/auth/login"
    case products = "/products"
}

class NetworkManager {
    static let shared: NetworkManager = NetworkManager()
    
    private init() {}
    
    func getAllProducts(success: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        let urlString = URLs.baseUrl.rawValue + URLs.products.rawValue
        guard let url = URL(string: urlString) else { return failure(nil) }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(nil)
                }
                return
            }
            
            // Data'yı string olarak konsola yazdır
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received data: \(jsonString)")
            }
            
            DispatchQueue.main.async {
                success(data)
            }
        }
        
        task.resume()
    }
    
    func getProduct(id: Int, success: @escaping (Data) -> Void, failure: @escaping (Error?) -> Void) {
        let urlString = URLs.baseUrl.rawValue + URLs.products.rawValue + "/\(id)"
        guard let url = URL(string: urlString) else { return failure(nil) }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    failure(nil)
                }
                return
            }
            
            
            // Data'yı string olarak konsola yazdır
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received data: \(jsonString)")
            }
            
            DispatchQueue.main.async {
                success(data)
            }
        }
        
        task.resume()
    }
}
*/



import Foundation

enum URLs: String {
    case baseUrl = "https://fakestoreapi.com"
    case products = "/products"
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func getAllProducts(completion: @escaping (Result<[Product], Error>) -> Void) {
        let urlString = URLs.baseUrl.rawValue + URLs.products.rawValue
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                }
                return
            }
            
            do {
                let products = try JSONDecoder().decode([Product].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(products))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
