//
//  ProductVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 02.08.24.
//




import UIKit
import FirebaseFirestore

 

class ProductVC: UIViewController {
    
    var tableView: UITableView!
    var products = [Product]()
    var category: Category!
    var listener: ListenerRegistration!
    var db: Firestore!
    var showFavorites = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupQuery()
    }

    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none // Remove the separator line

        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    func setupQuery() {
        let db = Firestore.firestore()
        
        var ref: Query!
        if showFavorites {
            ref = db.collection("users").document(AuthService.shared.user.id).collection("favorites")
        } else {
            ref = db.products(category: category.id)
        }
        
        listener = ref.addSnapshotListener { (snap, error) in
            if let error = error {
                debugPrint(error.localizedDescription)
                print("error.localizedDescription")
                return
            }
            
            snap?.documentChanges.forEach { (change) in
                let data = change.document.data()
                let product = Product(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, product: product)
                case .modified:
                    self.onDocumentModified(change: change, product: product)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            }
        }
    }
}

extension ProductVC: ProductCellDelegate {
    
    func productFavorited(product: Product) {
        AuthService.shared.favoriteSelected(product: product)
        guard let index = products.firstIndex(of: product) else { return }

        if showFavorites {
            products.remove(at: index)
            tableView.deleteSections(IndexSet(integer: index), with: .automatic)
        } else {
            tableView.reloadSections(IndexSet(integer: index), with: .automatic)
        }
        print("tıklandıııııı")
    }
}

extension ProductVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 189
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedProduct = products[indexPath.section]

        print("Selected product ID:", selectedProduct.id)

        let vc = ProductDetailVC()
        vc.product = selectedProduct
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext

        present(vc, animated: true, completion: nil)
    }
}

extension ProductVC: UITableViewDataSource {

    func onDocumentAdded(change: DocumentChange, product: Product) {
        let newIndex = Int(change.newIndex)
        products.insert(product, at: newIndex)
        tableView.insertSections(IndexSet(integer: newIndex), with: .fade)
    }

    func onDocumentModified(change: DocumentChange, product: Product) {
        if change.oldIndex == change.newIndex {
            let index = Int(change.newIndex)
            products[index] = product
            tableView.reloadSections(IndexSet(integer: index), with: .none)
        } else {
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            products.remove(at: oldIndex)
            products.insert(product, at: newIndex)
            tableView.moveSection(oldIndex, toSection: newIndex)
        }
    }

    func onDocumentRemoved(change: DocumentChange) {
        
        
        let oldIndex = Int(change.oldIndex)
            
            // Ensure the index is within the bounds of the array
            guard oldIndex < products.count else {
                return
            }
            
            products.remove(at: oldIndex)
            tableView.deleteSections(IndexSet(integer: oldIndex), with: .left)
        
//        let oldIndex = Int(change.oldIndex)
//        products.remove(at: oldIndex)
//        tableView.deleteSections(IndexSet(integer: oldIndex), with: .left)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("The dequeued cell is not an instance of ProductCell.")
        }
        
        let product = products[indexPath.section]
        cell.configure(with: product, delegate: self, shouldShowFavoriteButton: !showFavorites)
        
        cell.contentView.backgroundColor = .clrSecondaryBlack
        cell.layer.cornerRadius = 24
        cell.layer.masksToBounds = true
        
        cell.contentView.frame = cell.bounds.insetBy(dx: 16, dy: 10)
        return cell
    }
}
