//
//  ProductsView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct ProductsView: View {
    //MARK: Properties
    @StateObject var productsViewModel: ProductsViewModel
    
    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    //MARK: Body
    var body: some View {
        VStack {
            scrollView
            
            Spacer()
            
            cartView
        }
    }
    
    //MARK: Scroll View
    private var scrollView: some View {
        ScrollView(.vertical) {
            productsGrid
        }
        .padding()
    }
    
    //MARK: CartView
    private var cartView: some View {
        CartView(viewModel: productsViewModel.mainViewModel,
                 showAlert: $productsViewModel.mainViewModel.showAlert,
                 activeAlert: $productsViewModel.mainViewModel.activeAlert)
        .padding()
        .frame(height: 150)
    }
    
    //MARK: Products Grid
    private var productsGrid: some View {
        LazyVGrid(columns: gridColumns, content: {
            navigationLink
        })
    }
    
    //MARK: Navigation Link
    private var navigationLink: some View {
        ForEach(productsViewModel.filterProducts()) { product in
            VStack(spacing: 10) {
                NavigationLink(value: product, label: {
                    ProductCardView(product: product, imageWidth: 100, imageHeight: 100)
                        .frame(width: 175, height: 230)
                })
                .navigationDestination(for: Product.self, destination: { product in
                    ProductDetailView(
                        productDetailsViewModel: ProductDetailViewModel(
                            mainViewModel: productsViewModel.mainViewModel,
                            product: product,
                            path: productsViewModel.$path,
                            activeTab: productsViewModel.$activeTab))
                })
                
                addToCartButton(product: product)
                
                removeFromCartButton(product: product)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
    
    //MARK: Add to cart Button
    private func addToCartButton(product: Product) -> some View {
        Button {
            productsViewModel.mainViewModel.addToCart(product: product)
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 170, height: 30)
                    .foregroundStyle(.green.opacity(0.1))
                    .cornerRadius(8)
                
                HStack(spacing: 10, content: {
                    Image(systemName: "cart.badge.plus")
                    Text("Add to cart")
                        .font(.system(size: 15))
                        .bold()
                })
                .foregroundStyle(.black)
            }
        }
    }
    
    //MARK: Remove from cart Button
    private func removeFromCartButton(product: Product) -> some View {
        Button {
            productsViewModel.mainViewModel.removeFromCart(product: product)
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: 170, height: 30)
                    .foregroundStyle(.red.opacity(0.1))
                    .cornerRadius(8)
                
                HStack(spacing: 10, content: {
                    Image(systemName: "cart.badge.minus")
                    Text("Remove from cart")
                        .font(.system(size: 10))
                        .bold()
                })
                .foregroundStyle(.black)
            }
        }
    }
}
