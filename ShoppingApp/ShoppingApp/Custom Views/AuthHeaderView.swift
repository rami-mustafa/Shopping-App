//
//  AuthHeaderView.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 31.07.24.
//

import UIKit
import SnapKit

class AuthHeaderView: UIView {
    
    // MARK: - UI Components
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let subTitleLabel = UILabel()
    
    // MARK: - Init
    init(title: String, subTitle: String) {
        super.init(frame: .zero)
        setupView()
        configure(title: title, subTitle: subTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupView() {
        [titleLabel, subTitleLabel, logoImageView].forEach { addSubview($0) }
        
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .center
        
        subTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        subTitleLabel.textAlignment = .center
        subTitleLabel.textColor = .secondaryLabel
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(layoutMarginsGuide.snp.top).offset(100)
            make.leading.trailing.equalToSuperview()
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
        }
        
//        logoImageView.snp.makeConstraints { make in
//            make.top.equalTo(layoutMarginsGuide.snp.top).offset(16)
//            make.centerX.equalToSuperview()
//            make.width.equalTo(90)
//            make.height.equalTo(logoImageView.snp.width)
//        }
    }
    
    private func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
     }
}
