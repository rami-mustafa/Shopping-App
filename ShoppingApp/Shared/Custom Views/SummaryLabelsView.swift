//
//  SummaryLabelsView.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 05.08.24.
//

//"Subtotal",
//"Processing",
//"Shipping and Handling",


import UIKit
import SnapKit

class SummaryLabelsView: UIView {

    private let labels: [UILabel] = {
        let titles = [
            "Payment Method",
            "Shipping",
            "Total"
        ]
        
        return titles.map { title in
            let label = UILabel()
            label.text = title
            label.textAlignment = .left
            label.backgroundColor = .clear
            label.font = UIFont.systemFont(ofSize: 16)
            return label
        }
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        // Add labels to the view
        labels.forEach { label in
            addSubview(label)
        }
        
        // Set constraints for labels
        labels[0].snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(16)
        }
        
        for i in 1..<labels.count {
            labels[i].snp.makeConstraints { make in
                make.top.equalTo(labels[i - 1].snp.bottom).offset(18)
                make.left.equalToSuperview().inset(16)
                make.right.equalToSuperview().inset(16)
                make.height.equalTo(16)
            }
        }
        
        labels.last?.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(18)
        }
    }
}
