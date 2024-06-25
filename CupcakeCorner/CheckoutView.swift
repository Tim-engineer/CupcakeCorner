//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Tim Matlak on 24/06/2024.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 22))
                            .padding(.horizontal)
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 222)

                Text("Your total is \(order.cost, format: .currency(code: "EUR"))")
                    .font(.title3).bold()
                    .foregroundStyle(.mint)
                    .padding(.top)

                Button {
                    Task {
                        await placeOrder()
                    }
                } label: {
                    Text("Place Order")
                }
                .buttonStyle(.bordered)
                .tint(.cyan)
                .padding(.top)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert(alertTitle, isPresented: $showingAlert) { } message: {
            Text(alertMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertTitle = "Thank you!"
            alertMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingAlert = true
        } catch {
            print("Checkout failed: \(error.localizedDescription)")
            alertTitle = "OOPS!"
            alertMessage = "You are not connected to the internet. Try again later."
            showingAlert = true
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
