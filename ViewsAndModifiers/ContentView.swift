//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by faruk sirket on 21.11.2021.
//

import SwiftUI
struct CapsuleText: View{
    var text: String
    var body: some View{
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}
struct FarukView: View{
    var number: Int
    var body: some View{
       Text("Our number is \(number)")
            .bold()
            .monospacedDigit()
            .clipShape(Capsule())
            .background(.red)
    }
}
struct Title: ViewModifier{
    func body(content: Content) -> some View {
        content
                 .font(.largeTitle)
                 .foregroundColor(.white)
                 .padding()
                 .background(.blue)
                 .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
extension View {
    func titleStyle() -> some View{
        modifier(Title())
    }
}


struct ContentView: View {
    var body: some View {
        VStack{
            CapsuleText(text: "Özlem")
            CapsuleText(text: "Faruk")
                .background(.red)
            CapsuleText(text: "Duru")
            FarukView(number: 5)
                .titleStyle()
            Text("Hello world")
                .titleStyle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
