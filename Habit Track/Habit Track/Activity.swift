//
//  Activity.swift
//  Habit Track
//
//  Created by faruk sirket on 29.12.2021.
//

import Foundation
struct Activity: Identifiable, Codable{
    var id = UUID()
    let name: String
    let description: String
    var count: Int
}
class Activities: ObservableObject{
    @Published var activities: [Activity]{
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities){
                UserDefaults.standard.setValue(activities, forKey: "Activities")
            }
        }
    }
    init () {
        if let activities = UserDefaults.standard.data(forKey: "Activities"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Activity].self, from: activities){
                self.activities = decoded
                return
            }
        }
        self.activities = []
    }
    

}
