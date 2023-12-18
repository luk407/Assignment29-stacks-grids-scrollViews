//
//  StoreAppApp.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

enum activeTabView {
    case main, categories, products, productDetails
}

@main
struct StoreApp: App {
    //MARK: Properties
    @StateObject private var mainViewModel = MainViewModel()
    
    @State private var activeTab: activeTabView = .main
    
    @State private var path = NavigationPath()
    
    //MARK: Body
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path) {
                TabView(selection: $activeTab) {
                    MainView(viewModel: mainViewModel)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Main")
                        }
                        .tag(activeTabView.main)
                    
                    CategoriesView(categoriesViewModel: CategoriesViewModel(mainViewModel: mainViewModel, path: $path, activeTab: $activeTab))
                        .tabItem {
                            Image(systemName: "square.grid.2x2")
                            Text("Categories")
                        }
                        .tag(activeTabView.categories)
                }
            }
        }
    }
}
