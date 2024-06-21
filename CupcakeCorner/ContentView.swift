//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Tim Matlak on 17/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(height: 120)
                    
                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity)
                        .padding(.vertical)
                }
                
                Section {
                    Toggle("Special request", isOn: $order.specialRequestEnabled)
                    
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
            }
            .navigationTitle("CupcakeCorner")
        }
    }
}

#Preview {
    ContentView()
}
