//
//  ExpenseItem.swift
//  iExpense
//
//  Created by faruk sirket on 15.12.2021.
//

import Foundation
struct ExpenseItem: Identifiable, Codable{
    
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

