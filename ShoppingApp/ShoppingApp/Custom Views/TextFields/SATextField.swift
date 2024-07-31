//
//  SPTextField.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 31.07.24.
//



import UIKit

enum CustomTextFieldType {
    case username
    case email
    case password
}

class SATextField: UITextField {
    
    private let authFieldType: CustomTextFieldType
    
    init(fieldType: CustomTextFieldType) {
        self.authFieldType = fieldType
        super.init(frame: .zero)
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        backgroundColor = .systemGray2
        layer.cornerRadius = 10
        
        returnKeyType = .done
        autocorrectionType = .no
        autocapitalizationType = .none
        
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.size.height))
        leftViewMode = .always
        
        switch authFieldType {
        case .username:
            placeholder = "Username"
        case .email:
            placeholder = "Email Address"
            keyboardType = .emailAddress
            textContentType = .emailAddress
        case .password:
            placeholder = "Password"
            textContentType = .oneTimeCode
            isSecureTextEntry = true
        }
    }
}
