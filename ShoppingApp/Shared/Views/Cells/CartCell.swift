//
//  CartCell.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 28.07.24.
//



import UIKit
import SnapKit
import Kingfisher

protocol CartItemDelegate : class {
    func removeItem(product: Product)
}


class CartCell: UITableViewCell {
    
    
    weak var delegate : CartItemDelegate?
    private var item: Product!
    
    
    private let containerView = UIView()
    private let productImageView = UIImageView()
    private let productTitleLbl = UILabel()
    private let removeItemBtn = UIButton(type: .system)
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        

     
        selectionStyle = .none
        contentView.layer.cornerRadius = 24
        contentView.clipsToBounds = true

        addSubview(containerView)
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        containerView.backgroundColor = .clrSecondaryBlack
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        containerView.addSubview(productImageView)
        productImageView.layer.cornerRadius = 10
        productImageView.clipsToBounds = true
        productImageView.contentMode = .scaleAspectFill
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.width.height.equalTo(70)
        }

        containerView.addSubview(productTitleLbl)
        productTitleLbl.textColor = .white
        productTitleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView)
            make.left.equalTo(productImageView.snp.right).offset(20)
            make.right.equalToSuperview().inset(60)
        }
        
        containerView.addSubview(removeItemBtn)
        removeItemBtn.setImage(UIImage(systemName: "trash"), for: .normal)
        removeItemBtn.tintColor = .red
        removeItemBtn.addTarget(self, action: #selector(removeItemClicked), for: .touchUpInside)
        removeItemBtn.snp.makeConstraints { make in
            make.centerY.equalTo(productImageView)
            make.right.equalToSuperview().inset(20)
            make.height.width.equalTo(30)
        }
    }
    
    func configure(with product: Product, delegate : CartItemDelegate) {
        self.item = product
        self.delegate = delegate
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        if let price = formatter.string(from: product.price as NSNumber) {
            productTitleLbl.text = "\(product.name) \(price)"
        }
        
        if let url = URL(string: product.imageUrl) {
            productImageView.kf.setImage(with: url)
        }
    }
 
    @objc func removeItemClicked() {
        delegate?.removeItem(product: item)
    }
}






