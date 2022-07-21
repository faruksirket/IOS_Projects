//
//  Coordinator.swift
//  CoordinatorPattern
//
//  Created by faruk sirket on 21.07.2022.
//

import Foundation
import UIKit

enum Event{
    case buttonTapped
}

protocol Coordinator {
    var navigationController: UINavigationController? {get set}
    var children: [Coordinator]? {get set }
    
    func eventOccured (with type: Event)
    func start()
    
}

protocol Coordinating {
    var coordinator: Coordinator? { get set }
}
