//
//  ProfileVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//

import UIKit

class ProfileVC: UIViewController {

  
    
    // MARK: - Variables
    
    // MARK: - UI Components
    private let logOutButton        = SAButton(title: "New User? Create Account.", hasBackground: false, fontSize: .medium)

    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    // MARK: - UI Setup
    private func setupView(){
        
        
        logOutButton.setTitle("logOutB", for: .normal)
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        logOutButton.addTarget(self, action: #selector(logOutAction), for: .touchUpInside)
        
    }
    
    // MARK: - Selectors

    @objc func logOutAction(){
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
                return
            }
            
            
           
        }
    }

}
