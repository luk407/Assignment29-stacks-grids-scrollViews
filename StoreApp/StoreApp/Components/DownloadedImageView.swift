//
//  DownloadedImageView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

import SwiftUI

struct DownloadedImageView: View {
    //MARK: Properties
    var imageURL: URL
    var width: CGFloat
    var height: CGFloat
    
    //MARK: Body
    var body: some View {
        GeometryReader { geometry in
            downloadedImageView(geometry: geometry)
        }
        .frame(width: width, height: height)
        .cornerRadius(10)
    }
    
    //MARK: Downloaded AsyncImage View
    private func downloadedImageView(geometry: GeometryProxy) -> some View {
        AsyncImage(url: imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            case .failure:
                Image(systemName: "photo")
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            @unknown default:
                EmptyView()
            }
        }
    }
}

