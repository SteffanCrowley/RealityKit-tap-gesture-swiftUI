//
//  ContentView.swift
//  RealityKit-Gestures-testing-SwiftUI
//
//  Created by steffan crowley on 9/8/22.
//

import SwiftUI
import RealityKit
import RealityUI

struct ContentView : View {

    

    
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)
        arView.addGestureRecognizer(UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap)))
        
        context.coordinator.view = arView
        arView.session.delegate = context.coordinator
        
        let anchor = AnchorEntity(plane: .horizontal)
        let anchor2 = AnchorEntity(plane: .horizontal)
        let anchor3 = AnchorEntity(plane: .horizontal)
        let anchor4 = AnchorEntity(plane: .horizontal)
        
        RealityUI.registerComponents()
        RealityUI.enableGestures(.all, on: arView)
        
        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
        
        box.generateCollisionShapes(recursive: true)
        
        let newSwitch = RUISwitch(
          RUI: RUIComponent(respondsToLighting: true),
          changedCallback: { mySwitch in
              box.model?.materials = [
              SimpleMaterial(
                color: mySwitch.isOn ? .green : .red,
                isMetallic: true
              )
            ]
          }
        )
        
        newSwitch.transform = Transform(
          scale: .init(repeating: 0.15), rotation: .init(angle: .pi, axis: [0, 1, 0]), translation: [0, 0.20, -0.25]
        )
        
        let stepper = RUIStepper(upTrigger: { _ in
          print("positive tapped")
        }, downTrigger: { _ in
          print("negative tapped")
        })
        
        stepper.transform = Transform(
            scale: .init(repeating: 0.15), rotation: .init(angle: .pi, axis: [0, 1, 0]), translation: [0.5, 0.20, -0.25]
        )
        
        let newSlider = RUISlider(
          slider: SliderComponent(startingValue: 0.5, isContinuous: true)
        ) { (slider, _) in
            box.scale.x = slider.value + 0.5
        }
        
        newSlider.transform = Transform(
          scale: .init(repeating: 0.10), rotation: .init(angle: .pi, axis: [0, 1, 0]), translation: [0, 0.50, -0.25]
        )
        
        
        anchor.addChild(newSwitch)
        anchor2.addChild(box)
        anchor3.addChild(stepper)
        anchor4.addChild(newSlider)
        
        arView.scene.anchors.append(anchor)
        arView.scene.anchors.append(anchor2)
        arView.scene.anchors.append(anchor3)
        arView.scene.anchors.append(anchor4)
        
        return arView
        
    }
    
    func makeCoordinator() ->Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
