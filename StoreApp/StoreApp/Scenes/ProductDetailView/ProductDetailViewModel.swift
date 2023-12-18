//
//  ProductDetailViewModel.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

final class ProductDetailViewModel: ObservableObject {
    //MARK: Properties
    var mainViewModel: MainViewModel
    
    var product: Product?
    
    @Binding var path: NavigationPath
    
    @Binding var activeTab: activeTabView
    
    //MARK: Init
    init(mainViewModel: MainViewModel, product: Product? = nil, path: Binding<NavigationPath>, activeTab: Binding<activeTabView>) {
        self.mainViewModel = mainViewModel
        self.product = product
        self._path = path
        self._activeTab = activeTab
    }
    
    //MARK: Methods
    func returnToCategories() {
        path.removeLast(2)
    }
    
    func downloadAllImages() -> [DownloadedImageView] {
        var imagesArray: [DownloadedImageView] = []
        for image in product!.images {
            imagesArray.append(DownloadedImageView(imageURL: URL(string: image)!, width: 300, height: 400))
        }
        return imagesArray
    }
}
