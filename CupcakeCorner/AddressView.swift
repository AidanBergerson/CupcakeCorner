//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Aidan Bergerson on 12/30/24.
//

import SwiftUI

struct AddressView: View {
    
    @Bindable var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                    
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            if let data = try? JSONEncoder().encode(order) {
                UserDefaults.standard.set(data, forKey: "orderKey")
            }
        }
        .onAppear {
            if let object = UserDefaults.standard.value(forKey: "orderKey") as? Data {
                if let loadedOrder = try? JSONDecoder().decode(Order.self, from: object) {
                    self.order.name = loadedOrder.name
                    self.order.streetAddress = loadedOrder.streetAddress
                    self.order.city = loadedOrder.city
                    self.order.zip = loadedOrder.zip
                }
            }
        }
    }
}

#Preview {
    AddressView(order: Order())
}
