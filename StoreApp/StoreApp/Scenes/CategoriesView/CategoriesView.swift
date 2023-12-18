//
//  CategoriesView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct CategoriesView: View {
    //MARK: Properties
    @StateObject var categoriesViewModel: CategoriesViewModel
    
    //MARK: Body
    var body: some View {
        VStack {
            categoriesList
        }
        .padding()
        .task {
            categoriesViewModel.fetchCategoriesArray()
        }
    }
    
    //MARK: Categories List
    private var categoriesList: some View {
        List {
            ScrollView {
                listSection
            }
        }
        .listStyle(.plain)
    }
    
    //MARK: List Section
    private var listSection: some View {
        Section {
            navigationLink
        } header: {
            Text("Product Categories")
                .bold()
                .font(.system(size: 20))
        }
    }
    
    //MARK: Navigation Link
    private var navigationLink: some View {
        ForEach(categoriesViewModel.categoriesArray, id: \.self) { category in
            NavigationLink(value: category) {
                CategoryCardView(category: category)
                    .frame(height: 50)
            }
            .navigationDestination(for: String.self) { category in
                ProductsView(
                    productsViewModel: ProductsViewModel(
                        mainViewModel: categoriesViewModel.mainViewModel,
                        category: category,
                        path: categoriesViewModel.$path,
                        activeTab: categoriesViewModel.$activeTab))
            }
        }
    }
}
