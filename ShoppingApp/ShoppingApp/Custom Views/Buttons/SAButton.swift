//
//  SAButton.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 31.07.24.
//

import UIKit

enum FontSize {
    case big
    case medium
    case small
}

class SAButton: UIButton {
    
    init(title: String, hasBackground: Bool = false, fontSize: FontSize) {
        super.init(frame: .zero)
        setupButton(title: title, hasBackground: hasBackground, fontSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton(title: String, hasBackground: Bool, fontSize: FontSize) {
        setTitle(title, for: .normal)
        layer.cornerRadius = 12
        layer.masksToBounds = true
        
        backgroundColor = hasBackground ? .systemBlue : .clear
        setTitleColor(hasBackground ? .white : .systemBlue, for: .normal)
        
        switch fontSize {
        case .big:
            titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        case .medium:
            titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        case .small:
            titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }
}
