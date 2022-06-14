//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by faruk sirket on 30.12.2021.
//

import SwiftUI
extension String {
    var isValidName: Bool {
       let RegEx = "^\\w{7,18}$"
       let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
       return Test.evaluate(with: self)
    }
}
extension String{
    var validZipCode: Bool{
        let postalcodeRegex = "^[0-9]{5}(-[0-9]{4})?$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let bool = pinPredicate.evaluate(with: self) 
        return bool
    }
}

struct ContentView: View {
    
    @StateObject var order: Order
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your cake type", selection: $order.type){
                        ForEach(Order.types.indices){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes \(order.quantity)", value: $order.quantity, in: 3...20)
                    
                }
                Section{
                    Toggle("Any special requests", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section{
                    NavigationLink{
                        AddressView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(order: Order())
    }
}
