//
//  Favorite.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//



import UIKit

class CartVC: UIViewController {
    
    // MARK: - UI Components
    var tableView: UITableView!
    var totalPriceLabel: UILabel!
    var subtotalLabel: UILabel!
    var shippingLabel: UILabel!
    var proceedToCheckoutButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupFooterView()
        updateTotalPrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateTotalPrice()
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .white
        title = "My Cart"
        
        subtotalLabel = UILabel()
        subtotalLabel.textColor = .red
        subtotalLabel.font = UIFont.systemFont(ofSize: 18)
        
        shippingLabel = UILabel()
        shippingLabel.textColor = .red
        shippingLabel.font = UIFont.systemFont(ofSize: 18)
        
        totalPriceLabel = UILabel()
        totalPriceLabel.textColor = .red
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalPriceLabel.textAlignment = .center
        
        proceedToCheckoutButton = UIButton(type: .system)
        proceedToCheckoutButton.setTitle("Proceed to Checkout", for: .normal)
        proceedToCheckoutButton.backgroundColor = .black
        proceedToCheckoutButton.setTitleColor(.white, for: .normal)
        proceedToCheckoutButton.layer.cornerRadius = 10
        proceedToCheckoutButton.addTarget(self, action: #selector(proceedToCheckoutTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
    }

    
    private func setupFooterView() {
        let footerView = UIView()
        footerView.backgroundColor = .white
        view.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [subtotalLabel, shippingLabel, totalPriceLabel, proceedToCheckoutButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        footerView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func updateTotalPrice() {
 
        
 
    }
    
    @objc private func proceedToCheckoutTapped() {
        // Checkout işlemleri
        print("Proceed to Checkout")
    }
}
//
//extension CartVC: UITableViewDelegate, UITableViewDataSource {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return CartManager.shared.cartItems.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
//        let cartItem = CartManager.shared.cartItems[indexPath.row]
//        cell.configure(with: cartItem)
//        cell.delegate = self
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 130
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        let separatorHeight: CGFloat = 1.0
//        let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - separatorHeight, width: cell.frame.size.width, height: separatorHeight))
//        separatorView.backgroundColor = .lightGray
//        cell.contentView.addSubview(separatorView)
//    }
//}
//
//extension CartVC: CartCellDelegate {
//    func didUpdateQuantity(for product: Product, quantity: Int) {
//        CartManager.shared.updateProductQuantity(product, quantity: quantity)
//        tableView.reloadData()
//        updateTotalPrice()
//    }
//    
//    func didRemoveItem(for product: Product) {
//        CartManager.shared.removeProductFromCart(product)
//        tableView.reloadData()
//        updateTotalPrice()
//    }
//}
//





/*

import UIKit

class CartVC: UIViewController {
    
    // MARK: - UI Components
    var tableView: UITableView!
    var totalPriceLabel: UILabel!
    var subtotalLabel: UILabel!
    var shippingLabel: UILabel!
    var proceedToCheckoutButton: UIButton!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        setupFooterView()
        updateTotalPrice()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        updateTotalPrice()
    }
    
    // MARK: - UI Setup
    private func setupView() {
        view.backgroundColor = .white
        title = "My Cart"
        
        subtotalLabel = UILabel()
        subtotalLabel.font = UIFont.systemFont(ofSize: 18)
        
        shippingLabel = UILabel()
        shippingLabel.font = UIFont.systemFont(ofSize: 18)
        
        totalPriceLabel = UILabel()
        totalPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        totalPriceLabel.textAlignment = .center
        
        proceedToCheckoutButton = UIButton(type: .system)
        proceedToCheckoutButton.setTitle("Proceed to Checkout", for: .normal)
        proceedToCheckoutButton.backgroundColor = .black
        proceedToCheckoutButton.setTitleColor(.white, for: .normal)
        proceedToCheckoutButton.layer.cornerRadius = 10
        proceedToCheckoutButton.addTarget(self, action: #selector(proceedToCheckoutTapped), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CartCell.self, forCellReuseIdentifier: "CartCell")
        view.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightGray
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -200).isActive = true
    }

    
    private func setupFooterView() {
        let footerView = UIView()
        footerView.backgroundColor = .white
        view.addSubview(footerView)
        
        footerView.translatesAutoresizingMaskIntoConstraints = false
        footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [subtotalLabel, shippingLabel, totalPriceLabel, proceedToCheckoutButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        footerView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func updateTotalPrice() {
        let subtotal = CartManager.shared.getTotalPrice()
        let shipping = 17.0  // Sabit bir kargo ücreti
        let total = subtotal + shipping
        let itemCount = CartManager.shared.getTotalQuantity()
        
        subtotalLabel.text = "Subtotal: $\(subtotal)"
        shippingLabel.text = "Shipping: $\(shipping)"
        totalPriceLabel.text = "Bag Total (\(itemCount) items): $\(total)"
    }
    
    @objc private func proceedToCheckoutTapped() {
        // Checkout işlemleri
        print("Proceed to Checkout")
    }
}


extension CartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CartManager.shared.cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartCell
        let cartItem = CartManager.shared.cartItems[indexPath.row]
        cell.configure(with: cartItem)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let separatorHeight: CGFloat = 1.0
        let separatorView = UIView(frame: CGRect(x: 0, y: cell.frame.size.height - separatorHeight, width: cell.frame.size.width, height: separatorHeight))
        separatorView.backgroundColor = .lightGray
        cell.contentView.addSubview(separatorView)
    }
  
}







// MARK: - CartCellDelegate
extension CartVC: CartCellDelegate {
    
    
    
    func didUpdateQuantity(for product: Product, quantity: Int) {
        CartManager.shared.updateProductQuantity(product, quantity: quantity)
        tableView.reloadData()
        updateTotalPrice()
    }
    
    func didRemoveItem(for product: Product) {
        CartManager.shared.removeProductFromCart(product)
        tableView.reloadData()
        updateTotalPrice()
    }
    
    
    

 
}
 

*/
