//
//  CartView.swift
//  StoreApp
//
//  Created by Luka Gazdeliani on 17.12.23.
//

import SwiftUI

struct CartView: View {
    //MARK: Properties
    @StateObject var viewModel: MainViewModel
    @Binding var showAlert: Bool
    @Binding var activeAlert: ActiveAlert
    
    //MARK: Body
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10, content: {
                cartHeader
                
                totalQuantityView
                
                totalPriceView
                
                checkoutButton
            })
            .frame(width: geometry.size.width, height: 150)
        }
    }
    
    //MARK: Cart Header AKA "top row"
    private var cartHeader: some View {
        HStack {
            Text("Cart")
                .bold()
                .font(.system(size: 20))
            Spacer()
            Text("Balance: \(viewModel.balance.formatted(.currency(code: "USD")))")
                .foregroundStyle(.gray)
        }
    }
    
    //MARK: Total Quantity View
    private var totalQuantityView: some View {
        HStack {
            Text("Total Quantity: \(viewModel.totalAmount!)")
                .bold()
            Spacer()
        }
    }
    
    //MARK: Total Price View
    private var totalPriceView: some View {
        HStack {
            Text("Total Price: \(viewModel.totalPrice!.formatted(.currency(code: "USD")))")
                .bold()
            Spacer()
        }
    }
    
    //MARK: Checkout Button
    private var checkoutButton: some View {
        Button {
            viewModel.isCheckOutButtonTapped = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                viewModel.checkOutCartItems()
                viewModel.isCheckOutButtonTapped = false
            }
        } label: {
            if !viewModel.isCheckOutButtonTapped {
                checkoutButtonLabel
            } else {
                ProgressView()
            }
        }
        .alert(isPresented: $showAlert, content: {
            switch activeAlert {
            case .success:
                Alert(title: Text("Success"),
                      message: Text("You have successfully purchased items!"),
                      dismissButton: .cancel())
            case .failure:
                Alert(title: Text("Failure"),
                      message: Text("You don't have enough money on your balance!"),
                      dismissButton: .cancel())
            }
        })
    }
    
    //MARK: Checkout Button Button Label
    private var checkoutButtonLabel: some View {
        ZStack {
            Rectangle()
                .frame(width: 170, height: 30)
                .foregroundStyle(.blue.opacity(0.1))
                .cornerRadius(8)
            
            HStack(spacing: 10, content: {
                Image(systemName: "dollarsign.arrow.circlepath")
                Text("CheckOut")
                    .font(.system(size: 15))
                    .bold()
            })
            .foregroundStyle(.green)
        }
    }
}
