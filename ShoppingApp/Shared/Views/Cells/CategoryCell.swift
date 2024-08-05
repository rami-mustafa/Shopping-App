//
//  CategoryCell.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 02.08.24.
//

import UIKit
import Kingfisher


class CategoryCell: UICollectionViewCell {
    
    
    private let containerView    = UIView()
    private let categoryImg        = ProductImageView(frame: .zero)
    private let titleLabel       = UILabel()
 
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(containerView)
        containerView.addSubview(categoryImg)
        contentView.addSubview(titleLabel)
 
        
     
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        categoryImg.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
 
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            containerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.7),
            
            categoryImg.topAnchor.constraint(equalTo: containerView.topAnchor),
            categoryImg.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            categoryImg.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            categoryImg.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            

        ])
        
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 10
        containerView.layer.masksToBounds = true
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.clrSecondaryBlack.cgColor
        
        categoryImg.contentMode = .scaleAspectFill
        
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        titleLabel.textAlignment = .center
        
 

    }
    
    func configure(with category: Category) {
        titleLabel.text = category.name
//        imageView.downloadImage(fromURL: category.imgUrl)

        if let url = URL(string: category.imgUrl) {
            let placeholder = UIImage(named: "placeholder")
            let options : KingfisherOptionsInfo = [KingfisherOptionsInfoItem.transition(.fade(0.1))]
            categoryImg.kf.indicatorType = .activity
            categoryImg.kf.setImage(with: url, placeholder: placeholder, options: options)
        }
        
    }
}
