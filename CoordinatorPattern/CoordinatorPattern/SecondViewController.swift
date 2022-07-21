//
//  SecondViewController.swift
//  CoordinatorPattern
//
//  Created by faruk sirket on 21.07.2022.
//

import UIKit

class SecondViewController: UIViewController, Coordinating {
    var coordinator: Coordinator?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Second"
        view.backgroundColor = .systemBlue
       
    }

    

}
