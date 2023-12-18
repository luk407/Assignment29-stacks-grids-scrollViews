//
//  MainViewModel.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI
import GenericNetworkLayer

enum ActiveAlert {
    case success, failure
}

final class MainViewModel: ObservableObject {
    //MARK: Properties
    @Published var products: [Product] = []
    @Published var activeAlert: ActiveAlert = .failure
    @Published var isCheckOutButtonTapped = false
    @Published var showAlert = false
    @Published var downloadedImage: UIImage?
    @Published var balance = 1000.00
    var totalPrice: Double? { products.reduce(0) { $0 + Double($1.price) * Double(($1.selectedAmount ?? 0))} }
    var totalAmount: Int? { products.reduce(0) { $0 + ($1.selectedAmount ?? 0)}}
    
    //MARK: Init
    init() {
        fetchProductData()
    }
    
    //MARK: Methods
    private func fetchProductData() {
        let urlString = "https://dummyjson.com/products"
        guard let url = URL(string: urlString) else { return }
        
        NetworkManager().request(with: url) { [weak self] (result: Result<ProductData, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    self?.products = data.products
                case .failure(_):
                    break
                }
            }
        }
    }
    
    func downloadImage(urlString: String) -> UIImage {
        NetworkManager().downloadImage(from: urlString) { image in
            guard let image else { return }
            
            DispatchQueue.main.async {
                self.downloadedImage = image
            }
        }
        return downloadedImage ?? UIImage(systemName: "circle")!
    }
    
    func addToCart(product: Product) {
        guard let index = products.firstIndex(where: { $0.id == product.id } ) else { return }
        
        if products[index].selectedAmount == nil {
            products[index].selectedAmount = 1
        } else {
            products[index].selectedAmount! += 1
        }
    }
    
    func removeFromCart(product: Product) {
        guard let index = products.firstIndex(where: { $0.id == product.id } ) else { return }

        if products[index].selectedAmount != nil && products[index].selectedAmount! > 0  {
            products[index].selectedAmount! -= 1
        }
    }
    
    func checkOutCartItems() {
        guard let totalPrice else { return }
        if balance > totalPrice {
            balance -= totalPrice
            activeAlert = .success
            showAlert = true
            emptyCart()
        } else {
            activeAlert = .failure
            showAlert = true
        }
    }
    
    private func emptyCart() {
        for index in products.indices {
            products[index].selectedAmount = 0
        }
    }
}
