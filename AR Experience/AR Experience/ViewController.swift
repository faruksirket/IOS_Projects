//
//  ViewController.swift
//  AR Experience
//
//  Created by faruk sirket on 3.08.2022.
//

import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Create 3D model
        
        let sphere = MeshResource.generateSphere(radius: 0.05)
        let material = SimpleMaterial(color: .red, roughness: 0, isMetallic: true)
        let sphereEntity = ModelEntity(mesh: sphere, materials: [material])
        
        // Create anchor
        
        let sphereAnchor = AnchorEntity(world: SIMD3(x: 0, y: 0, z: 0))
        sphereAnchor.addChild(sphereEntity)
        
        //Add anchor to scene
        arView.scene.addAnchor(sphereAnchor)
        
    }
}
