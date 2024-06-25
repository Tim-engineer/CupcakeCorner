//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Tim Matlak on 21/06/2024.
//

import SwiftUI

struct AddressView: View {
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .onChange(of: order.name) { order.saveToUserDefaults() }
                TextField("Street Address", text: $order.streetAddress)
                    .onChange(of: order.streetAddress) { order.saveToUserDefaults() }
                TextField("City", text: $order.city)
                    .onChange(of: order.city) { order.saveToUserDefaults() }
                TextField("Zip", text: $order.zip)
                    .onChange(of: order.zip) { order.saveToUserDefaults() }
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: order.loadFromUserDefaults)
    }
}

#Preview {
    NavigationStack {
        AddressView(order: Order())
    }
}
