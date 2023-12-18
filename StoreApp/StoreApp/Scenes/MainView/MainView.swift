//
//  ContentView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct MainView: View {
    //MARK: Properties
    @StateObject var viewModel: MainViewModel
    private let gridColumns = [GridItem(.flexible()), GridItem(.flexible())]
    
    //MARK: Body
    var body: some View {
        VStack {
            headerView
            
            scrollView
            
            cartView
        }
        .padding()
    }
    
    //MARK: Header View
    private var headerView: some View {
        HStack(spacing: 20) {
            Image(systemName: "storefront.fill")
                .resizable()
                .frame(width: 30, height: 30)
            Text("StoreApp")
                .font(.system(size: 30))
            Spacer()
        }
        .foregroundStyle(.pink)
    }
    
    //MARK: ScrollView
    private var scrollView: some View {
        ScrollView {
            productsVGrid
        }
    }
    
    //MARK: CartView
    private var cartView: some View {
        CartView(viewModel: viewModel, showAlert: $viewModel.showAlert, activeAlert: $viewModel.activeAlert)
            .frame(height: 150)
    }
    
    //MARK: Products LazyVGrid
    private var productsVGrid: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(viewModel.products) { product in
                productCard(product: product)
            }
        }
    }
    
    //MARK: Product Card
    private func productCard(product: Product) -> some View {
        VStack(spacing: 10) {
            ProductCardView(product: product, imageWidth: 100, imageHeight: 100)
                .frame(width: 175, height: 230)
            
            addToCartButton(product: product)
            
            removeFromCartButton(product: product)
        }
        .overlay(
        RoundedRectangle(cornerRadius: 8)
            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
        )

    }
    
    //MARK: Add to cart Button
    private func addToCartButton(product: Product) -> some View {
        Button {
            viewModel.addToCart(product: product)
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
            viewModel.removeFromCart(product: product)
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


