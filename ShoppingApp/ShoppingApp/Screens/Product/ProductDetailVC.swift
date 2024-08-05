//
//  DetailVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//


import UIKit
import SnapKit
import SwiftUI
import Kingfisher

class ProductDetailVC: UIViewController {
    
    // MARK: - Variables
    var product: Product!
    
    // UI Elements
    private let containerView    = UIView()
    private let imageView        = UIImageView()
    private let productTitle     = UILabel()
    private let priceLabel       = UILabel()

    private let productDescription = UILabel()
    private let addToCartButton = UIButton(type: .system)
    private let keepShoppingButton = UIButton(type: .system)
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark)) // Bulanık arka plan için


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        setupBlurBackground()

        setupConstraints()
        configure(with: product)
    }
  
    func setupBlurBackground() {
           view.addSubview(visualEffectView)  // Bulanık arka planı ana görünüme ekle
           visualEffectView.frame = view.bounds  // Bulanık arka planın boyutlarını ayarla
           visualEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]  // Responsive design için
       }
    

    
    private func setupConstraints() {

        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(productTitle)
        containerView.addSubview(productDescription)
        containerView.addSubview(addToCartButton)
        containerView.addSubview(priceLabel)
        containerView.addSubview(keepShoppingButton)
        
        containerView.backgroundColor = .clrSecondaryBlack
        containerView.layer.cornerRadius = 20
        containerView.clipsToBounds = true
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(450)
        }
        
        
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(200)
        }
        
        productTitle.text = "sdfnlsadfnksan"
        productTitle.textAlignment = .center
        productTitle.textColor = .clrTextSecondary
        productTitle.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(10)
         }
        
        priceLabel.textColor = .gray
        priceLabel.textAlignment = .center
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(productTitle.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(10)
         }
        
        productDescription.textAlignment = .center
        productDescription.textColor = .gray
        productDescription.numberOfLines = 2
        productDescription.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(25)
         }
        
        
        
        addToCartButton.backgroundColor =  AppColors.Blue
        addToCartButton.layer.cornerRadius = 10
        addToCartButton.setTitle("Add to Cart", for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addToCartButton.addTarget(self, action: #selector(addCartClicked), for: .touchUpInside)
        addToCartButton.snp.makeConstraints { make in
            make.top.equalTo(productDescription.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
        
        keepShoppingButton.backgroundColor = AppColors.Red
        keepShoppingButton.layer.cornerRadius = 10
        keepShoppingButton.setTitle("Keep Shoppimg", for: .normal)
        keepShoppingButton.setTitleColor(.white, for: .normal)
        keepShoppingButton.addTarget(self, action: #selector(dismissProduct), for: .touchUpInside)
        keepShoppingButton.snp.makeConstraints { make in
            make.top.equalTo(addToCartButton.snp.bottom).offset(5)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(40)
        }
    }
    
    func configure(with product: Product){
        
        
        print("dnfsdnfsdjfnsdnfn ",product.id)
        
        productTitle.text = product.name
        productDescription.text = product.productDescription
        
        if let url = URL(string: product.imageUrl) {
            imageView.kf.setImage(with: url)
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            priceLabel.text = price
        }
        
 
    }
    
    
    
    @objc func addCartClicked() {
        StripeCart.addItemToCart(item: product)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func dismissProduct() {
        dismiss(animated: true, completion: nil)
    }
}


//
//#Preview{
//    ProductDetailVC()
//}
