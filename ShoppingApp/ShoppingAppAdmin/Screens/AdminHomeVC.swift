//
//  ViewController.swift
//  ShoppingAppAdmin
//
//  Created by Rami Mustafa on 31.07.24.
//

import UIKit
import SnapKit




class AdminHomeVC: HomeVC {
    
    private var addCategoryBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = AppColors.Background
        setupNavigationBar()
        setupCollectionViewConstraints()
    }
    
    private func setupNavigationBar() {
        let title = UILabel()
        title.text = "Admin"
        title.textColor = .white
        title.textAlignment = .center
        view.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
        }
        
        addCategoryBtn = UIButton()
        addCategoryBtn.setTitle("Add Category", for: .normal)
        addCategoryBtn.setTitleColor(.gray, for: .focused)
        addCategoryBtn.addTarget(self, action: #selector(addCategory), for: .touchUpInside)
        view.addSubview(addCategoryBtn)
        addCategoryBtn.snp.makeConstraints { make in
            make.centerY.equalTo(title)
            make.right.equalToSuperview().inset(30)
        }
    }
    
    private func setupCollectionViewConstraints() {
        collectionView.backgroundColor = .clear
        collectionView.snp.remakeConstraints { make in
            make.top.equalTo(addCategoryBtn.snp.bottom).offset(20)
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    @objc func addCategory() {
        print("Add Category tapped")
        let vc = AddEditCategoryVC()
        self.present(vc, animated: true)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item]
        
        let adminProductsVC = AdminProductsVC()
        adminProductsVC.modalPresentationStyle = .fullScreen
        adminProductsVC.category = selectedCategory
        present(adminProductsVC, animated: true)
    }
}





//
//class AdminHomeVC: HomeVC {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        setupNavigationBar()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    func setupNavigationBar() {
//        title = "Admin"
//
//        let addCategoryBtn = UIBarButtonItem(title: "Add Category", style: .plain, target: self, action: #selector(addCategory))
//        navigationItem.rightBarButtonItem = addCategoryBtn
//    }
//
//    @objc func addCategory() {
//        // Kategori ekleme işlemini burada yapın
//        print("Add Category tapped")
//
//        let VC = AddEditCategoryVC()
//        navigationController?.pushViewController(VC, animated: true)
//    }
//
//
//
//}
//
