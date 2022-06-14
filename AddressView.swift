//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by faruk sirket on 31.12.2021.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form{
            Section{
                TextField("Name: ", text: $order.name)
                TextField("Street Address: ", text: $order.streetAddress)
                TextField("City: ", text: $order.city)
                TextField("Zip code: ", text: $order.zip)
            }
            Section{
                NavigationLink{
                    CheckoutViewForChallenge3(order: MyOrder())
                } label: {
                    Text("Checkout view")
                }
                .disabled(order.hasValidAddress == false)
            }.navigationTitle("Delivery details")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddressView(order: Order())
        }
    }
}
