//
//  ProductDetailsCardView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 18.12.23.
//

import SwiftUI

struct ProductDetailsCardView: View {
    //MARK: Properties
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffSet: CGFloat = 0
    var imagesArray: [DownloadedImageView]
    var product: Product
    
    //MARK: Body
    var body: some View {
        GeometryReader { geometry in
            cardZStack(geometry: geometry)
        }
    }
    
    private func cardZStack(geometry: GeometryProxy) -> some View {
        ZStack {
            rectangleView(geometry: geometry)
            
            cardContentView()
        }
    }
    
    //MARK: Rectangle View (for Background)
    private func rectangleView(geometry: GeometryProxy) -> some View {
        Rectangle()
            .frame(width: geometry.size.width, height: geometry.size.height)
            .foregroundStyle(.gray.opacity(0.1))
            .cornerRadius(10)
    }
    
    //MARK: Card Content View
    private func cardContentView() -> some View {
        VStack(spacing: 20, content: {
            imageCarouselView
            
            productInfoView
        })
    }
    
    //TODO: Image Carousel View
    private var imageCarouselView: some View {
        ZStack {
            ForEach(0..<imagesArray.count, id: \.self) { index in
                imageAtIndex(index: index)
            }
        }
        .gesture(
        DragGesture()
            .onEnded({ value in
                let threshold: CGFloat = 50
                if value.translation.width > threshold {
                    withAnimation {
                        currentIndex = max(0, currentIndex - 1)
                    }
                } else if value.translation.width < -threshold {
                    withAnimation {
                        currentIndex = min(imagesArray.count - 1, currentIndex + 1)
                    }
                }
            })
        )
    }
    
    //MARK: Image at Index
    private func imageAtIndex(index: Int) -> some View {
        imagesArray[index]
            .opacity(currentIndex == index ? 1.0 : 0.5)
            .scaleEffect(currentIndex == index ? 1.0 : 0.8)
            .offset(x: CGFloat(index - currentIndex) * 300 + dragOffSet, y: 0)
    }
    
    //MARK: Product Info View
    private var productInfoView: some View {
        VStack(spacing: 20) {
            productTitleView
            
            productBrandView
            
            productPriceView
            
            productDescriptionView
            
            Spacer()
            
            productRatingView
        }
        .padding()
    }
    
    //MARK: Product Title
    private var productTitleView: some View {
        HStack(spacing: 10) {
            Text("\(product.title)")
                .bold()
                .font(.system(size: 20))
            Spacer()
        }
    }
    
    //MARK: Product Brand
    private var productBrandView: some View {
        HStack(spacing: 10) {
            Text("Brand: \(product.brand)")
                .bold()
                .font(.system(size: 15))
            Spacer()
        }
    }
    
    //MARK: Product Price
    private var productPriceView: some View {
        HStack(spacing: 10) {
            Text("Price: \(product.price.formatted(.currency(code: "USD")))")
                .font(.system(size: 15))
                .foregroundStyle(.gray)
            Spacer()
        }
    }
    
    //MARK: Product Description
    private var productDescriptionView: some View {
        HStack(spacing: 10) {
            Text("Description: \(product.description)")
                .font(.system(size: 15))
            Spacer()
        }
    }
    
    //MARK: Product Rating
    private var productRatingView: some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundStyle(.yellow)
            Text("\(String(format: "%.2f", product.rating))")
                .font(.system(size: 15))
                .foregroundStyle(.gray)
        }
    }
}

