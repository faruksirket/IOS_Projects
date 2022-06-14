//
//  AddActivity.swift
//  Habit Track
//
//  Created by faruk sirket on 29.12.2021.
//

import SwiftUI

struct AddActivity: View {
    @State private var name = ""
    @State private var description = ""
    @Environment (\.presentationMode) var presentationMode
    @ObservedObject var activities: Activities
    @State private var showingAlert = false
   
    var body: some View {
        NavigationView{
            Form{
                TextField("Activity name: ", text: $name)
                TextField("Activity description: ", text: $description)
            }
            .navigationTitle("Add activity")
            .toolbar{
                ToolbarItem{
                    Button("Save"){
                        if self.name != "" && self.description != "" {
                            let activity = Activity(name: name, description: description, count: 0)
                            self.activities.activities.append(activity)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            self.showingAlert.toggle()
                        }
                    }
                }
            }
            .alert(isPresented: $showingAlert){
                Alert(title: Text("Oops "), message: Text("You have to fill the TextFields"), dismissButton: .default(Text("OK")))
            }
        }
    }
}

