//
//  ProductDetailView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct ProductDetailView: View {
    //MARK: Properties
    @StateObject var productDetailsViewModel: ProductDetailViewModel
    
    //MARK: Body
    var body: some View {
        VStack {
            productDetailsCardView
            
        }
        .padding()
        .toolbar{
            returnToCategoriesButton
        }
    }
    
    //MARK: Product Details Card View
    private var productDetailsCardView: some View {
        ProductDetailsCardView(imagesArray: productDetailsViewModel.downloadAllImages(), product: productDetailsViewModel.product ?? productDetailsViewModel.mainViewModel.products[0])
    }
    
    //MARK: Return to Categories Button
    private var returnToCategoriesButton: some View {
        Button {
            productDetailsViewModel.returnToCategories()
        } label: {
            Text("Return To Categories")
        }
    }
}
