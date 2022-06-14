//
//  DataController.swift
//  Bookworm
//
//  Created by faruk sirket on 8.01.2022.
//

import CoreData
import Foundation
import UIKit

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "Bookworm")
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
            }
        }
    }
}
