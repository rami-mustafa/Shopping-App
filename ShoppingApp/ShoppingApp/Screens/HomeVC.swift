//
//  HomeVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//



import UIKit

class HomeVC: UIViewController {
    
    var collectionView: UICollectionView!
    var products: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         setupCollectionView()
        fetchProducts()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 15, height: 250)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        
        view.addSubview(collectionView)
    }
    
    func fetchProducts() {
        NetworkManager.shared.getAllProducts { result in
            switch result {
            case .success(let products):
                self.products = products
                self.collectionView.reloadData()
            case .failure(let error):
                print("Failed to fetch products:", error)
            }
        }
    }
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCell
        let product = products[indexPath.row]
        cell.configure(with: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        
        let product = products[indexPath.row]
        let detailVC = DetailVC()
        detailVC.product = product
        navigationController?.pushViewController(detailVC, animated: true)
        
        
    }
    
    
}
