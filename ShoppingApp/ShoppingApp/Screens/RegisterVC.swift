//
//  RegisterVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 31.07.24.
//

import UIKit

class RegisterVC: UIViewController {

    
    
    // MARK: - UI Components
    private let headerView    = AuthHeaderView(title: "Sign UP", subTitle: "Create your account")
    private let usernameField = SATextField(fieldType: .username)
    private let passwordField = SATextField(fieldType: .password)
    private let emailField    = SATextField(fieldType: .email)
    private let signUpButton  = SAButton(title: "Sign Up", hasBackground: true , fontSize: .big)
    private let signInButton  = SAButton(title: "Already have an account? Sign In." , fontSize: .medium)
    
    
    private let termsTextView: UITextView = {
        let tv = UITextView()
        tv.text = "dsbfdsbfkdsbfkdsbfk kdsbfnksdkfbsd ksdnfksdkf ksdnfksdf dnsfksdnfnds knbdsfknbdskf kdnsfksnfkns dsnbfksdf "
        tv.backgroundColor = .clear
        tv.textColor       = .label
        tv.isSelectable    = true
        tv.isEditable      = false
        tv.isScrollEnabled = false
       return tv
    }()

    // MARK: - LifeCycle
        override func viewDidLoad() {
            super.viewDidLoad()
            Setup()
            
        }
    
    // MARK: - UI Setup
    
    func Setup(){
        
        view.backgroundColor = .systemGray4

        
        view.backgroundColor = .white
        [headerView , usernameField , passwordField , emailField , signUpButton , signInButton , termsTextView ].forEach { box in
            view.addSubview(box)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(210)
        }
        
        usernameField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)

            make.height.equalTo(50)
            
            
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(usernameField.snp.bottom).offset(15)
         
                make.height.equalTo(50)
            
            
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(emailField.snp.bottom).offset(15)
            make.height.equalTo(50)
            
            
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            make.height.equalTo(50)
            
            
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        termsTextView.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(6)
            make.height.equalTo(50)
            
            
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(termsTextView.snp.bottom).offset(11)
            make.height.equalTo(40)
            
            
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        
        self.signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        self.signUpButton.addTarget(self, action: #selector(didTapSignUp), for: .touchUpInside)

        
   
    }
    
    // MARK: - Selectors
    
    @objc private func didTapSignIn() {
        dismiss(animated: true)
    }
  
    @objc private func didTapSignUp(){
   
        /*
        let registerUserRequest = RegiserUserRequest(
                    username: self.usernameField.text ?? "",
                    email: self.emailField.text ?? "",
                    password: self.passwordField.text ?? ""
                )
        
        
        
        // Username check
        if !Validator.isValidUsername(for: registerUserRequest.username) {
            AlertManager.showInvalidUsernameAlert(on: self)
            return
        }
        
        // Email check
        if !Validator.isValidEmail(for: registerUserRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: registerUserRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else { return }
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuthentication()
                }
            } else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
        }
        
        */
    }

}
