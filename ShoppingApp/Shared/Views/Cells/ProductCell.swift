//
//  ProductCell.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//


import UIKit
import Kingfisher
 


protocol ProductCellDelegate : AnyObject {
    func productFavorited(product: Product)
//    func productAddToCart(product: Product)
}


class ProductCell: UITableViewCell {

    weak var delegate : ProductCellDelegate?
    private var product: Product!

    
    
    private let productImageView = UIImageView()
    private let titleLabel = UILabel()
    private let productPrice = UILabel()
    private let favoriteButton = UIButton(type: .system)
    
    private var isFavorite: Bool = false {
           didSet {
               let imageName = isFavorite ? "heart.fill" : "heart"
               favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
           }
       }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clrSecondaryBlack
        selectionStyle = .none
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true
        
        productImageView.contentMode = .scaleAspectFill
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
        contentView.addSubview(productImageView)
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        contentView.addSubview(titleLabel)
        
        productPrice.textAlignment = .center
        productPrice.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        productPrice.textColor = .lightGray
        productPrice.numberOfLines = 2
        contentView.addSubview(productPrice)
        
        
        
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.tintColor = .red
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        contentView.addSubview(favoriteButton)
        
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        productImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
              productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
              productImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
              productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
              productImageView.widthAnchor.constraint(equalToConstant: 145),
              
              titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
              titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
              titleLabel.trailingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: -20),
              
              
              productPrice.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
              productPrice.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
              productPrice.trailingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: -8),

              favoriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
              favoriteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
              favoriteButton.widthAnchor.constraint(equalToConstant: 30),
              favoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    func configure(with product: Product , delegate: ProductCellDelegate , shouldShowFavoriteButton:Bool) {
      
        self.product = product
        self.delegate = delegate
        
        titleLabel.text = product.name

        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        if let price = formatter.string(from: product.price as NSNumber) {
            productPrice.text = price
        }
 
        if let url = URL(string: product.imageUrl) {
            let placeholder = UIImage(named: "placeholder")
            productImageView.kf.indicatorType = .activity
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.2))]
            productImageView.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
        
//        if AuthService.shared.favorites.contains(product) {
//            isFavorite = true
//        } else {
//            isFavorite = false
//        }
        
        
        isFavorite = AuthService.shared.favorites.contains(product)
        favoriteButton.isHidden = !shouldShowFavoriteButton

    }
    
    @objc private func toggleFavorite() {
           isFavorite.toggle()
           delegate?.productFavorited(product: product)

       }
}


