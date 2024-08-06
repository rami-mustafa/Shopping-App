//
//  AddEditProductsVC.swift
//  ShoppingAppAdmin
//
//  Created by Rami Mustafa on 04.08.24.
//

import UIKit
import SnapKit
import Kingfisher

class AddEditProductsVC: UIViewController {
    
    // MARK: - UI Components
    private let backButton         = UIButton()
    private let titleLabel         = UILabel()
    private let nameProductTF      = UITextField()
    private let priceProductTF     = UITextField()
    private let productDescTxt     = UITextView()
    private let subTileLabel       = UILabel()
    private var categoryImg        = UIImageView()
    private let activityIndicator  = UIActivityIndicatorView(style: .large)
    private let addBtn             = UIButton()
    
    // Variables
    var selectedCategory : Category!
    var productToEdit : Product?
    
    var name = ""
    var price = 0.0
    var productDescription = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = AppColors.Background
        
        configuraUI()
        configureData()
    }
    
    
    
    private func configuraUI() {
        
        let backIcon = UIImage(systemName: "arrowshape.backward.fill")
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        nameProductTF.placeholder = "Product Name"
        nameProductTF.backgroundColor = .clrTextSecondary
        nameProductTF.layer.cornerRadius = 10
        nameProductTF.clipsToBounds = true
        nameProductTF.borderStyle = .roundedRect
        let placeholderTxt = "Product Name"
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        nameProductTF.attributedPlaceholder = NSAttributedString(string: placeholderTxt, attributes: attributes)
        view.addSubview(nameProductTF)
        
        priceProductTF.placeholder = "Product Price"
        priceProductTF.backgroundColor = .clrTextSecondary
        priceProductTF.layer.cornerRadius = 10
        priceProductTF.borderStyle = .roundedRect
        priceProductTF.clipsToBounds = true
        priceProductTF.textColor = UIColor.white 
        let placeholderText = "Product Price"
        let attributesForPrice: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        priceProductTF.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributesForPrice)
        view.addSubview(priceProductTF)
        
        titleLabel.text = "Enter Description Below"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 17)
        view.addSubview(titleLabel)
        
        productDescTxt.layer.cornerRadius = 10
        productDescTxt.backgroundColor = .systemFill
        view.addSubview(productDescTxt)
        
        subTileLabel.text = "Tap to add image"
        subTileLabel.textAlignment = .center
        subTileLabel.textColor = .white
        subTileLabel.font = .systemFont(ofSize: 17)
        view.addSubview(subTileLabel)
        
        categoryImg.isUserInteractionEnabled = true
        categoryImg.layer.cornerRadius = 10
        categoryImg.image = UIImage(systemName: "camera.shutter.button")
        categoryImg.tintColor = .white
        categoryImg.backgroundColor = .systemFill
        categoryImg.contentMode = .center
        categoryImg.clipsToBounds = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        tap.numberOfTapsRequired = 1
        categoryImg.addGestureRecognizer(tap)
        view.addSubview(categoryImg)
        
        addBtn.setTitle("Add Product", for: .normal)
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.layer.cornerRadius = 20
        addBtn.clipsToBounds = true
        addBtn.addTarget(self, action: #selector(addCategoryClicked(_:)), for: .touchUpInside)
        view.addSubview(addBtn)
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        nameProductTF.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(40)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(40)
        }
        
        priceProductTF.snp.makeConstraints { make in
            make.top.equalTo(nameProductTF.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(priceProductTF.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(40)
        }
        
        productDescTxt.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(110)
        }
        
        subTileLabel.snp.makeConstraints { make in
            make.top.equalTo(productDescTxt.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(25)
            make.height.equalTo(40)
        }
        
        categoryImg.snp.makeConstraints { make in
            make.top.equalTo(subTileLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(70)
            make.height.equalTo(150)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.top.equalTo(categoryImg.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(60)
        }
        
        addBtn.backgroundColor = AppColors.Blue
        addBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func configureData() {
        if let product = productToEdit {
            nameProductTF.text = product.name
            productDescTxt.text = product.productDescription
            priceProductTF.text = String(product.price)
            addBtn.setTitle("Save Changes", for: .normal)
            
            if let url = URL(string: product.imageUrl) {
                categoryImg.contentMode = .scaleAspectFill
                categoryImg.kf.setImage(with: url)
            }
        }
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImgPicker()
    }
    
    @objc func addCategoryClicked(_ sender: Any) {
        uploadImageThenDocument()
    }
    
    private func uploadImageThenDocument() {
        guard let image = categoryImg.image,
              let name = nameProductTF.text, !name.isEmpty,
              let description = productDescTxt.text, !description.isEmpty,
              let priceString = priceProductTF.text,
              let price = Double(priceString) else {
            AlertManager.showMissingFields(on: self)
            return
        }
        
        self.name = name
        self.productDescription = description
        self.price = price
        
        activityIndicator.startAnimating()
        FirebaseManager.shared.uploadProductImageAndDocument(image: image, productName: name, selectedCategory: selectedCategory, productToEdit: productToEdit, description: description, price: price) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                switch result {
                case .success(let downloadURL):
                    print("Download URL: \(downloadURL)")
                    self.dismiss(animated: true)
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    AlertManager.showUnableToUploadProduct(on: self)
                }
            }
        }
    }
}

extension AddEditProductsVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImgPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        categoryImg.contentMode = .scaleAspectFill
        categoryImg.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
