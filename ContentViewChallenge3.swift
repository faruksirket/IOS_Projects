//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by faruk sirket on 30.12.2021.
//

import SwiftUI


struct ContentViewChallenge3: View {
    
    @ObservedObject var order: MyOrder
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake typ", selection: $order.orderStruct.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.orderStruct.quantity)", value: $order.orderStruct.quantity, in: 3...20)
                    
                }
                Section{
                    Toggle("Any special requests", isOn: $order.orderStruct.specialRequestEnabled.animation())
                    if order.orderStruct.specialRequestEnabled {
                        Toggle("Extra frosting", isOn: $order.orderStruct.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.orderStruct.addSprinkles)
                    }
                }
                Section{
                    NavigationLink{
                        AddressViewForChallenge3(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
}
struct ContentViewChallenge3_Previews: PreviewProvider {
    static var previews: some View {
        ContentViewChallenge3(order: MyOrder())
    }
}


