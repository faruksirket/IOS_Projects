//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by faruk sirket on 31.12.2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingNoInternet = false
    @State private var noInternetMessage = ""
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3){image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }.frame(height: 233)
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                Button("Place order"){
                    Task{
                        await placeOrder()
                    }
                }
                    .padding()
            }
        }.navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("Thank you", isPresented: $showingConfirmation){
                Button("OK"){
                    
                }
            } message: {
                Text(confirmationMessage)
            }
            .alert("Error", isPresented: $showingNoInternet){
                Button("OK"){
                    
                }
            }message: {
                Text(noInternetMessage)
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
        request.httpMethod = "POST"
        
        do{
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodeOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodeOrder.quantity) x \(Order.types[decodeOrder.type].lowercased()) is on its way. "
                showingConfirmation = true
            
        } catch {
            showingNoInternet = true
            noInternetMessage = "You have no internet connection"
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            CheckoutView(order: Order())
        }
    }
}
