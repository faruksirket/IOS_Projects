//
//  CheckoutViewChallenge3.swift
//  CupcakeCorner
//
//  Created by faruk sirket on 3.01.2022.
//

import SwiftUI

struct CheckoutViewForChallenge3: View {
    @ObservedObject var order: MyOrder
    
    // MARK: Challenge 2
    @State private var confirmationTitle = ""
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                    .resizable()
                    .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("You total is \(self.order.orderStruct.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                .padding()
                }
           
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) { () -> Alert in
            Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func placeOrder() {
        // 1. Convert our current order object into some JSON data that can be sent.
        
        guard let encoded = try? JSONEncoder().encode(order.orderStruct) else {
            print("Failed to encode order")
            return
        }
        
        // 2. Prepare a URLRequest to send our encoded data as JSON.
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        // 3. Run that request and process the response.
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            // handle the result here.
            guard let data = data else {
                // MARK: Chellenge 2
                self.confirmationTitle = "WARNING!!!"
                self.confirmationMessage = "No data in response: \(error?.localizedDescription ?? "Unknown")"
                self.showingConfirmation = true
                print("No data in response: \(error?.localizedDescription ?? "Unknown error"). ")
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(OrderStruct.self, from: data) {
                self.confirmationTitle = "Thank You"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(OrderStruct.types[decodedOrder.type].lowercased()) cupcakes in on its way!"
                self.showingConfirmation = true
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutViewForChallenge3_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutViewForChallenge3(order: MyOrder())
    }
}
