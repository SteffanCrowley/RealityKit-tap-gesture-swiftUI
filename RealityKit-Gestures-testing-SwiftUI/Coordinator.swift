//
//  Coordinator.swift
//  RealityKit-Gestures-testing-SwiftUI
//
//  Created by steffan crowley on 9/8/22.
//

import Foundation
import ARKit
import RealityKit

class Coordinator: NSObject, ARSessionDelegate {
    
    weak var view: ARView?
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        
        
        guard let view = self.view else {
            return
        }
        
        let tapLocation = recognizer.location(in: view)

        
        if let entity = view.entity(at: tapLocation) as? ModelEntity {
            //changes color from blue to yellow if tapped
            let material = SimpleMaterial(color: .yellow, isMetallic: true)
            entity.model?.materials = [material]
            //prints if tapped
            print("the box was hit!")
        }
    }
}
