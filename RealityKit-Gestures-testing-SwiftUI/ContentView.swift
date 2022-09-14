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
        
        
        RealityUI.registerComponents()
        RealityUI.enableGestures(.all, on: arView)
        
        let testAnchor = AnchorEntity(world: [0, 0, -1])

        let clickySphere = ClickyEntity(
          model: ModelComponent(mesh: .generateBox(size: 0.2), materials: [SimpleMaterial(color: .red, isMetallic: false)])
        ) {
            (clickedObj, atPosition) in
            // In this example we're just assigning the colour of the clickable
            // entity model to a green SimpleMaterial.
            (clickedObj as? HasModel)?.model?.materials = [
                SimpleMaterial(color: .green, isMetallic: false)
            ]
            print("testing 1 2 3")
            
            
        }

        testAnchor.addChild(clickySphere)
        arView.scene.addAnchor(testAnchor)
        
//         let anchor = AnchorEntity(plane: .horizontal)
        
//        let box = ModelEntity(mesh: MeshResource.generateBox(size: 0.1), materials: [SimpleMaterial(color: .red, isMetallic: true)])
//
//        box.generateCollisionShapes(recursive: true)
//
//        let newSwitch = RUISwitch(
//          RUI: RUIComponent(respondsToLighting: true),
//          changedCallback: { mySwitch in
//              box.model?.materials = [
//              SimpleMaterial(
//                color: mySwitch.isOn ? .green : .red,
//                isMetallic: true
//              )
//            ]
//          }
//        )
//
//        newSwitch.transform = Transform(
//          scale: .init(repeating: 0.15), rotation: .init(angle: .pi, axis: [0, 1, 0]), translation: [0, 0.20, -0.25]
//        )
//
//        let stepper = RUIStepper(upTrigger: { _ in
//          print("positive tapped")
//        }, downTrigger: { _ in
//          print("negative tapped")
//        })
//
//        stepper.transform = Transform(
//            scale: .init(repeating: 0.15), rotation: .init(angle: .pi, axis: [0, 1, 0]), translation: [0.5, 0.20, -0.25]
//        )
//
//        let newSlider = RUISlider(
//          slider: SliderComponent(startingValue: 0.5, isContinuous: true)
//        ) { (slider, _) in
//            box.scale.x = slider.value + 0.5
//        }
//
//        newSlider.transform = Transform(
//          scale: .init(repeating: 0.10), rotation: .init(angle: .pi, axis: [0, 1, 0]), translation: [0, 0.50, -0.25]
//        )
//
//        let text = ModelEntity(mesh: MeshResource.generateText("Incoming Call", extrusionDepth: 0.05, font: .systemFont(ofSize: 0.1), containerFrame: .zero, alignment: .center, lineBreakMode: .byCharWrapping), materials: [SimpleMaterial(color: .green, isMetallic: true)])
//
//        text.transform = Transform(translation: [-1.0, 0.20, -0.25]
//        )
//
//        text.ruiSpin(by: [0, 1, 0], period: 1, times: -1)
//
//
//        anchor.addChild(newSwitch)
//        anchor.addChild(box)
//        anchor.addChild(stepper)
//        anchor.addChild(newSlider)
//        anchor.addChild(text)
//
//        arView.scene.anchors.append(anchor)
        
        return arView
        
    }
    
    func makeCoordinator() ->Coordinator {
        Coordinator()
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

/// Example class that uses the HasClick protocol
class ClickyEntity: Entity, HasClick, HasModel {
  // Required property from HasClick
  var tapAction: ((HasClick, SIMD3<Float>?) -> Void)?

    init(model: ModelComponent, tapAction: @escaping ((HasClick, SIMD3<Float>?) -> Void)) {
    self.tapAction = tapAction
    super.init()
    self.model = model
    self.generateCollisionShapes(recursive: false)
  }

  required convenience init() {
     self.init()
  }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
