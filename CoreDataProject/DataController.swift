//
//  DataController.swift
//  CoreDataProject
//
//  Created by faruk sirket on 25.01.2022.
//

import CoreData
import Foundation
import UIKit

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init(){
        container.loadPersistentStores{description, error in
            if let error = error {
                print("Core data failed to load \(error.localizedDescription)")
                return
            }
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}
