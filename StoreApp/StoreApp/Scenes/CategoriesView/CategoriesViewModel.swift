//
//  CategoriesViewModel.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

final class CategoriesViewModel: ObservableObject {
    //Properties
    @ObservedObject var mainViewModel: MainViewModel
    
    @Binding var path: NavigationPath
    
    @Binding var activeTab: activeTabView
    
    @Published var categoriesArray: [String] = []
    
    //MARK: List
    init(mainViewModel: MainViewModel, path: Binding<NavigationPath>, activeTab: Binding<activeTabView>, categoriesArray: [String] = []) {
        self.mainViewModel = mainViewModel
        self._path = path
        self._activeTab = activeTab
        self.categoriesArray = categoriesArray
    }
    
    //MARK: Methods
    func fetchCategoriesArray() {
        for product in mainViewModel.products {
            if categoriesArray.contains(product.category) == false {
                categoriesArray.append(product.category)
            }
        }
    }
}
