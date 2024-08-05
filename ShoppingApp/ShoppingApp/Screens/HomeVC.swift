//
//  HomeVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//



import UIKit
import FirebaseCore
import FirebaseFirestore



class HomeVC: UIViewController {
    
    var categories = [Category]()
    var selectedCategory: Category!
    var listener : ListenerRegistration!

    // MARK: - UI Components
    private let logOutButton = SAButton(title: "logOut", hasBackground: false, fontSize: .medium)
    var collectionView: UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        
        getUser()
        setupCollectionView()
        setupLogOutButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setCategoriesListener()

    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        listener.remove()
        categories.removeAll()
        collectionView.reloadData()
    }
    
    
    private func getUser(){
        AuthService.shared.getCurrentUser()
    }
    
    private func setupLogOutButton() {
        
        
        let logOutButton = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutAction))
        navigationItem.leftBarButtonItem = logOutButton
        
      
      }
  
    func setupCollectionView() {
        
        logOutButton.setTitle("logOut", for: .normal)
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        
 
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 15, height: 300)
        
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = AppColors.Background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        
        view.addSubview(collectionView)
    }
    
    @objc func logOutAction(){
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
        }
    }
    
    func setCategoriesListener() {
        let db = Firestore.firestore()
        let docRef = db.categories

        listener = docRef.addSnapshotListener({ (snap, error) in
            
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            snap?.documentChanges.forEach({ (change) in
                
                let data = change.document.data()
                let category = Category.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, category: category)
                case .modified:
                    self.onDocumentModified(change: change, category: category)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
        })
    }
    
  
    func onDocumentAdded(change: DocumentChange, category: Category) {
        let newIndex = Int(change.newIndex)
        categories.insert(category, at: newIndex)
        collectionView.insertItems(at: [IndexPath(item: newIndex, section: 0)])
    }
    
    func onDocumentModified(change: DocumentChange, category: Category) {
        if change.newIndex == change.oldIndex {
            // Item changed, but remained in the same position
            let index = Int(change.newIndex)
            categories[index] = category
            collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        } else {
            // Item changed and changed position
            let oldIndex = Int(change.oldIndex)
            let newIndex = Int(change.newIndex)
            categories.remove(at: oldIndex)
            categories.insert(category, at: newIndex)
            
            collectionView.moveItem(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
        }
    }
    
    func onDocumentRemoved(change: DocumentChange) {
        let oldIndex = Int(change.oldIndex)
        categories.remove(at: oldIndex)
        collectionView.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
    }
    
    
}


extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let categories = categories[indexPath.row]
        cell.configure(with: categories)
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCategory = categories[indexPath.item]
 
        
 
        let productVC = ProductVC()
        productVC.category = selectedCategory
        productVC.showFavorites = false
        navigationController?.pushViewController(productVC, animated: true)
    }
    
}





//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.deselectItem(at: indexPath, animated: true)
//        let product = products[indexPath.row]
//        let detailVC = DetailVC()
//        detailVC.product = product
//        navigationController?.pushViewController(detailVC, animated: true)
//    }



/**

func fetchDocument() {
    


    let db = Firestore.firestore()
    
 
    listener = docRef.addSnapshotListener { (snap, error) in
        guard let documents = snap?.documents else {
            print("Error fetching document: \(error!)")
            return
        }
               self.categories.removeAll()
         
        
               for document in documents {
                   let data = document.data()
                   let newCategory = Category.init(data: data)
                   self.categories.append(newCategory)
               }
               self.collectionView.reloadData()
           }

}
 */
