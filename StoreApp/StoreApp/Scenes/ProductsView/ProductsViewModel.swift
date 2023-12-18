//
//  ProductsViewModel.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

final class ProductsViewModel: ObservableObject {
    //MARK: Properties
    @ObservedObject var mainViewModel: MainViewModel
    
    var category: String
    
    @Binding var path: NavigationPath
    
    @Binding var activeTab: activeTabView
    
    @Published var filteredProducts: [Product] = []
    
    //MARK: Init
    init(mainViewModel: MainViewModel, category: String = "", path: Binding<NavigationPath>, activeTab: Binding<activeTabView>, filteredProducts: [Product] = []) {
        self.mainViewModel = mainViewModel
        self.category = category
        self._path = path
        self._activeTab = activeTab
        self.filteredProducts = filteredProducts
    }
    
    //MARK: Methods
    func filterProducts() -> [Product] {
        mainViewModel.products.filter { $0.category == category }
    }
}
