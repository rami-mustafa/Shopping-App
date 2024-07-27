//
//  ProductCell.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//


import UIKit

class ProductCell: UICollectionViewCell {
    
    private let containerView    = UIView()
    private let imageView        = UIImageView()
    private let titleLabel       = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel       = UILabel()
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(descriptionLabel)
        
        
     
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        descriptionLabel.textColor = .systemGray
        descriptionLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descriptionLabel.numberOfLines = 1
        descriptionLabel.textAlignment = .center
        
        priceLabel.textColor = .black
        priceLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        priceLabel.textAlignment = .center
 

    }
    
    func configure(with product: Product) {
        titleLabel.text = product.title
        priceLabel.text = "$\(product.price)"
        descriptionLabel.text = product.description
        
        
        // Görseli yüklemek için URLSession kullanarak basit bir image loader
        if let url = URL(string: product.image) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, error == nil {
                    DispatchQueue.main.async {
                        self.imageView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}
