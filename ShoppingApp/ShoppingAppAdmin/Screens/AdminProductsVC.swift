//
//  AdminProductsVC.swift
//  ShoppingAppAdmin
//
//  Created by Rami Mustafa on 04.08.24.
//

import UIKit

class AdminProductsVC: ProductVC {
    
    
    
    // MARK: - Variables
    var selectedProduct : Product?
 
    // MARK: - UI Components
    private let editCategoryBtn = UIButton()
    private let addProductBtn   = UIButton()
    private let backButton      = UIButton()
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.Background
        setupView()
    }
    
    // MARK: - UI Setup
    private func setupView() {
        configureButtons()
        configureTableView()
    }
    
    private func configureButtons() {
        
        // Add Product Button
        addProductBtn.setTitle("Add Product", for: .normal)
        addProductBtn.setTitleColor(.gray, for: .focused)
        addProductBtn.addTarget(self, action: #selector(addCProduct), for: .touchUpInside)
        view.addSubview(addProductBtn)
        addProductBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
        }
        
        // Edit Category Button
        editCategoryBtn.setTitle("Edit Category", for: .normal)
        editCategoryBtn.setTitleColor(.gray, for: .focused)
        editCategoryBtn.addTarget(self, action: #selector(editCategory), for: .touchUpInside)
        view.addSubview(editCategoryBtn)
        editCategoryBtn.snp.makeConstraints { make in
            make.centerY.equalTo(addProductBtn)
            make.right.equalToSuperview().inset(7)
            make.height.equalTo(30)
        }
        
        // Back Button
        let backIcon = UIImage(systemName: "arrowshape.backward.fill")
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.centerY.equalTo(addProductBtn)
            make.left.equalToSuperview().inset(20)
        }
    }
    
    private func configureTableView() {
        
        tableView.removeFromSuperview()
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(addProductBtn.snp.bottom).offset(20)
            make.left.right.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
    
    // MARK: - Selectors
    @objc func addCProduct() {
        print("Add Category tapped")
        let vc = AddEditProductsVC()
        vc.selectedCategory = category

        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func editCategory() {
     
        let vc = AddEditCategoryVC()
        vc.categoryToEdit = category
        vc.modalPresentationStyle = .fullScreen
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
}

extension AdminProductsVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedProduct = products[indexPath.section]
        let vc = AddEditProductsVC()
        vc.productToEdit = selectedProduct
        vc.selectedCategory = category
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        
        present(vc, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductCell else {
            fatalError("The dequeued cell is not an instance of ProductCell.")
        }
        
        let product = products[indexPath.section]
        cell.configure(with: product, delegate: self, shouldShowFavoriteButton: showFavorites)
        
        cell.contentView.backgroundColor = .clrSecondaryBlack
        cell.layer.cornerRadius = 24
        cell.layer.masksToBounds = true
        
        cell.contentView.frame = cell.bounds.insetBy(dx: 16, dy: 10)
        return cell
    }
}
