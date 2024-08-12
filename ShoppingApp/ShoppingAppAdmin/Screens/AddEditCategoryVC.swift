//
//  AddEditCategoryVC.swift
//  ShoppingAppAdmin
//
//  Created by Rami Mustafa on 04.08.24.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import SnapKit


class AddEditCategoryVC: UIViewController {
    
    // MARK: - Variables
    var categoryToEdit: Category?
    
    
    // MARK: - UI Components
   private let backButton         = UIButton()
   private let titleLabel         =  UILabel()
   private var nameTxt            =  UITextField()
   private var categoryImg        = UIImageView()
   private let activityIndicator  = UIActivityIndicatorView(style: .large)
   private let addBtn             =  UIButton()
   private let subTitleLabel      = UILabel()
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = AppColors.Background
        setupViews()
        
        if let category = categoryToEdit {
            nameTxt.text = category.name
            addBtn.setTitle("Save Changes", for: .normal)
            
            if let url = URL(string: category.imgUrl) {
                categoryImg.kf.setImage(with: url)
            }
        }
        
        
    }
    
 
    func setupViews() {
        
        
        let backIcon = UIImage(systemName: "arrowshape.backward.fill")
        backButton.setImage(backIcon, for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        
        titleLabel.text = "Category Name"
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
             
        nameTxt.placeholder = "Gategory Name"
        nameTxt.backgroundColor = .clrTextSecondary
        nameTxt.layer.cornerRadius = 10
        nameTxt.borderStyle = .roundedRect
        nameTxt.clipsToBounds = true
        let placeholderText = "Gategory Name"
        let attributesForPrice: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        nameTxt.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributesForPrice)
        view.addSubview(nameTxt)
        
        
        subTitleLabel.text = "Tap image to add category image"
        subTitleLabel.textColor = .white
        subTitleLabel.textAlignment = .center
        view.addSubview(subTitleLabel)
        
        categoryImg.isUserInteractionEnabled = true
        categoryImg.contentMode = .scaleAspectFill
        categoryImg.layer.cornerRadius = 20
        categoryImg.clipsToBounds = true
        categoryImg.image = UIImage(systemName: "camera.shutter.button")
        categoryImg.tintColor = .white
        categoryImg.contentMode = .center
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        tap.numberOfTapsRequired = 1
        categoryImg.addGestureRecognizer(tap)
        view.addSubview(categoryImg)
        
        activityIndicator.color = .gray
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        
        addBtn.setTitle("Add Category", for: .normal)
        addBtn.setTitleColor(.white, for: .normal)
        addBtn.layer.cornerRadius = 20
        addBtn.clipsToBounds = true
        
        addBtn.addTarget(self, action: #selector(addCategoryClicked(_:)), for: .touchUpInside)
        view.addSubview(addBtn)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(30)
        }
        
        
        nameTxt.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTxt.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        categoryImg.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(50)
            make.height.equalTo(250)
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
    
    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImgPicker()
    }
    
    @objc func addCategoryClicked(_ sender: Any) {
        uploadImageThenDocument()
    }
    
    
    
    func uploadImageThenDocument() {
  
        if let categoryName = nameTxt.text, !categoryName.isEmpty {
            
            FirebaseManager.shared.checkCategoryExists(categoryName: categoryName) { exists in
                if exists {
                    AlertManager.showCategoryAlreadyExistsAlert(on: self)
                } else {
 
                    if let image = self.categoryImg.image {
                        self.activityIndicator.startAnimating()
                        
                        FirebaseManager.shared.uploadCategoryImageAndDocument(image: image, categoryName: categoryName, categoryToEdit: self.categoryToEdit) { result in
                            
                            
                            DispatchQueue.main.async {
                                self.activityIndicator.stopAnimating()
                                switch result {
                                case .success(let downloadURL):
                                    print("Download URL: \(downloadURL)")
                                     let vc = AdminHomeVC()
                                    vc.modalPresentationStyle = .fullScreen
                                    self.present(vc, animated: true)
                                case .failure(let error):
                                    print("Error: \(error.localizedDescription)")
                                 }
                            }
                        }
                    } else {
                        print("Please select an image for the category.")
                     }
                }
            }
        } else {
            AlertManager.showCategoryImageAndNameRequiredAlert(on: self)
        }
   
    }
    
    
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
}




extension AddEditCategoryVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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



