//
//  ProductImageView.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 28.07.24.
//

 
import UIKit

class ProductImageView: UIImageView {
    
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        layer.cornerRadius = 10
        clipsToBounds = true
     }
    
  
}
