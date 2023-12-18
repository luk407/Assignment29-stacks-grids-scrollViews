//
//  ProductModel.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import Foundation

// MARK: Product Data
struct ProductData: Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}

// MARK: - Product
struct Product: Decodable, Identifiable, Hashable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let discountPercentage: Double
    let rating: Double
    var stock: Int
    let brand: String
    let category: String
    let thumbnail: String
    let images: [String]
    var selectedAmount: Int?
}
