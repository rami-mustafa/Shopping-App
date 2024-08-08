//
//  ForgotPasswordVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 06.08.24.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    // MARK: - Variables
    
    // MARK: - UI Components
    private let headerView = AuthHeaderView(title: "Forgot Password", subTitle: "Reset your password")
    private let emailField = SATextField(fieldType: .email)
    private let resetPasswordButton = SAButton(title: "Sign Up", hasBackground: true, fontSize: .big)
    
    
    
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Setup()
        
        self.resetPasswordButton.addTarget(self, action: #selector(didTapresetPassword), for: .touchUpInside)
        
    }
    
    // MARK: - UI Setup
    
    func Setup(){
        
        view.backgroundColor = .clrSecondaryBlack
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBack))
        
        [headerView , emailField , resetPasswordButton ].forEach { box in
            view.addSubview(box)
        }
        
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(210)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
            make.height.equalTo(50)
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        resetPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
    }
    
    // MARK: - Selectors
    @objc func didTapresetPassword(){
        
        let email = self.emailField.text ?? ""
        
        if !Validator.isValidEmail(for: email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        AuthService.shared.forgotPassword(with: email) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showErrorSendingPasswordReset(on: self, with: error)
                return
            }
            
            AlertManager.showPasswordResetSent(on: self)
            dismiss(animated: true)
        }
        
        
    }
    
    @objc func didTapBack(){
        
        dismiss(animated: true)
    }

}
