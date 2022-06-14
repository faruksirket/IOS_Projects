//
//  ContentView.swift
//  WeSplit
//
//  Created by faruk sirket on 15.11.2021.
//

import SwiftUI

struct ContentView: View {
@State private var checkAmount = 0.0
@State private var numberOfPeople = 2
@State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
let tipPercentages = [10, 15, 20, 25, 0]
    
var amountPerPserson: Double {
    let amountPeople = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let checkPerPerson = grandTotal / amountPeople
    return checkPerPerson
}



var body: some View {
    NavigationView{
        Form{
                Section{
                    TextField("Amount: ", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .keyboardType(.numberPad)
                .focused($amountIsFocused)
                    Picker("Number of people:",selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                }
                Section{
                    Picker("Tip selection: ", selection: $tipPercentage){
                        ForEach(0..<3){
                            Text($0, format: .percent)
                        }
                    } .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(amountPerPserson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                Section{
                    Text((amountPerPserson * Double(numberOfPeople + 2)), format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                } header: {
                    Text("grand total")
                        .foregroundColor(tipPercentage == 0 ? .red : .blue)
                }
        }
        .navigationTitle("WeSplit")
        .toolbar{
            ToolbarItemGroup(placement: .keyboard){
                Spacer()
                Button("Done"){
                    amountIsFocused = false
                }
            }
        }
    }
    
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

