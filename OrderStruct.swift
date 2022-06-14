//
//  OrderStruct.swift
//  CupcakeCorner
//
//  Created by faruk sirket on 3.01.2022.
//

import Foundation
import SwiftUI
class MyOrder: ObservableObject{
    @Published var orderStruct = OrderStruct()
}

struct OrderStruct: Codable{
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    var type = 0
    var quantity = 3
    var extraFrosting = false
    var addSprinkles = false
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    var specialRequestEnabled = false {
        didSet{
            extraFrosting = false
            addSprinkles = false
        }
    }
    var hasValidAddress: Bool {
        if !(name.isValidName) || name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty || zip.validZipCode {
            return false
        }
        return true
    }
    var cost: Double{
        // $2 for per quantity
        var cost = Double(quantity) * 2
        
        // for other cupcake types
        cost += Double(type) / 2
        
        // $1 for extra frosting
        
        if extraFrosting{
            cost += Double(quantity)
        }
        
        // $0.5 for add sprinkles
        
        if addSprinkles{
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    enum CodingKeys: CodingKey{
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip
    }
    init() {}
}
