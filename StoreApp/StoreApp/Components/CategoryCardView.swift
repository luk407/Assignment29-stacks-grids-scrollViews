//
//  CategoryCardView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct CategoryCardView: View {
    //MARK: Properties
    var category: String
    
    //MARK: Body
    var body: some View {
        ZStack {
            rectangleView
            
            categoryTitleView
        }
    }
    
    //MARK: Rectangle View (for Background)
    private var rectangleView: some View {
        GeometryReader { geometry in
            Rectangle()
                .frame(width: geometry.size.width, height: 50)
                .foregroundStyle(.gray.opacity(0.1))
                .cornerRadius(10)
        }
    }
    
    private var categoryTitleView: some View {
        HStack {
            Text("\(category.uppercased())")
                .font(.system(size: 15))
            
            Spacer()
        }
        .padding()
    }
}
