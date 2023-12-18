//
//  ProductCardView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct ProductCardView: View {
    //MARK: Properties
    var product: Product
    var imageWidth: CGFloat
    var imageHeight: CGFloat
    
    //MARK: Body
    var body: some View {
        ZStack {
            rectangleView
            
            cardContentView
        }
    }
    
    //MARK: Rectangle View (for Background)
    private var rectangleView: some View {
        Rectangle()
            .frame(width: 175, height: 230)
            .foregroundStyle(.gray.opacity(0.1))
            .cornerRadius(8)
    }
    
    //MARK: Card Content
    private var cardContentView: some View {
        VStack(spacing: 10, content: {
            productImageView
            
            productInfoView
        })
        .padding()
    }
    
    //MARK: Product Image View
    private var productImageView: some View {
        DownloadedImageView(imageURL: URL(string: product.thumbnail)!, width: 100, height: 100)
    }
    
    //MARK: Product Info View
    private var productInfoView: some View {
        VStack(spacing: 15) {
            productTitleView
            productPriceView
        }
        .padding()
    }
    
    //MARK: Product Title View
    private var productTitleView: some View {
        HStack {
            Text("\(product.title)")
                .font(.system(size: 14))
                .bold()
            Spacer()
        }
    }
    
    //MARK: Product Price View
    private var productPriceView: some View {
        HStack {
            Text("Price: \(product.price.formatted(.currency(code: "USD")))")
                .font(.system(size: 10))
                .foregroundStyle(.gray)
            Spacer()
        }
    }
}
