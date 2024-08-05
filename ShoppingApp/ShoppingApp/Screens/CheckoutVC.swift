//
//  CheckoutVC.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 05.08.24.
//

import UIKit
import SnapKit

class CheckoutVC: UIViewController , CartItemDelegate{

    // MARK: - Variables
    // MARK: - UI Components
    private let tableView = UITableView()
    private let summaryLabelsView = SummaryLabelsView()
    private var products: [Product] = []
    
    
    private var totalLbl = UILabel()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = .black
        configureUI()
        configureTableView()
        setupPaymentInfo()
        addNotificationObserver()
    }

 
    
    func setupPaymentInfo() {
        totalLbl.text = StripeCart.subtotal.penniesToFormattedCurrency()

        /*
        processingFeeLbl.text = StripeCart.processingFees.penniesToFormattedCurrency()
        shippingCostLbl.text = StripeCart.shippingFees.penniesToFormattedCurrency()
        totalLbl.text = StripeCart.total.penniesToFormattedCurrency()
         */
    }
    private func configureUI() {
        summaryLabelsView.backgroundColor = .clear
        view.addSubview(summaryLabelsView)
        summaryLabelsView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-60)
            make.left.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        view.addSubview(tableView)

        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(summaryLabelsView.snp.top).offset(-10)
        }
        
        
        totalLbl.textColor = .white
        totalLbl.textAlignment = .right
        totalLbl.font = .systemFont(ofSize: 18)
        view.addSubview(totalLbl)
        totalLbl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-80)
            make.right.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        
    }

    private func addNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(cartItemsDidChange), name: .cartItemsChanged, object: nil)
    }

    @objc private func cartItemsDidChange() {
        tableView.reloadData()
        setupPaymentInfo()
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .cartItemsChanged, object: nil)
    }
    
    func removeItem(product: Product) {
        StripeCart.removeItemFromCart(item: product)
   


    }
}

// MARK: - UITableViewDataSource
extension CheckoutVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StripeCart.cartItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as? CartCell else {
            return UITableViewCell()
        }
        let product = StripeCart.cartItems[indexPath.row]
        cell.configure(with: product, delegate: self)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CheckoutVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



