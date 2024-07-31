//
//  LoginVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 31.07.24.
//


import UIKit
import SnapKit

class LoginVC: UIViewController {
    
    // MARK: - UI Components
    private let headerView           = AuthHeaderView(title: "Sign In", subTitle: "Welcome to my page")
    private let emailField           = SATextField(fieldType: .email)
    private let passwordField        = SATextField(fieldType: .password)
    private let signInButton         = SAButton(title: "Sign In", hasBackground: true, fontSize: .big)
    private let newUserButton        = SAButton(title: "New User? Create Account.", hasBackground: false, fontSize: .medium)
    private let forgotPasswordButton = SAButton(title: "Forgot Password?", hasBackground: false, fontSize: .small)
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .systemGray4
        
        [headerView, emailField, passwordField, signInButton, newUserButton, forgotPasswordButton].forEach { view.addSubview($0) }
        
        setupConstraints()
        
      
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(210)
        }
        
        emailField.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(10)
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
        
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(passwordField.snp.bottom).offset(15)
            make.height.equalTo(50)
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        newUserButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(11)
            make.height.equalTo(50)
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(newUserButton.snp.bottom).offset(6)
            make.height.equalTo(50)
            make.centerX.equalTo(headerView)
            make.width.equalTo(view).multipliedBy(0.85)
        }
        
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        newUserButton.addTarget(self, action: #selector(didTapNewUser), for: .touchUpInside)
        forgotPasswordButton.addTarget(self, action: #selector(didTapForgotPassword), for: .touchUpInside)
    }
    
    // MARK: - Selectors
    @objc private func didTapSignIn() {
        // Authentication logic here
        /*
        let loginRequest = LoginUserRequest(
            email: self.emailField.text ?? "",
            password: self.passwordField.text ?? ""
        )
        
        // Email check
        if !Validator.isValidEmail(for: loginRequest.email) {
            AlertManager.showInvalidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(for: loginRequest.password) {
            AlertManager.showInvalidPasswordAlert(on: self)
            return
        }
        
        AuthService.shared.signIn(with: loginRequest) { error in
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
            
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuthentication()
            }
        }
        */
    }
    
    @objc private func didTapNewUser() {
        // Navigate to registration
        print("didTapNewUser")
        
        /*
        let vc = RegisterController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
        */
    }
    
    @objc private func didTapForgotPassword() {
        // Navigate to forgot password
        print("didTapForgotPassword")
        
        print("didTapForgotPassword")
    /*
        let vc = ForgotPasswordController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
        */
        
    }
}
