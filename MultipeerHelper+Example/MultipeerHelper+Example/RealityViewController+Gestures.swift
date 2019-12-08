//
//  RealityViewController+Gestures.swift
//  MultipeerHelper+Example
//
//  Created by Max Cobb on 11/23/19.
//  Copyright © 2019 Max Cobb. All rights reserved.
//

import ARKit
import RealityKit
import UIKit

extension RealityViewController: UIGestureRecognizerDelegate {

  func setupGestures() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
    self.arView.addGestureRecognizer(tap)
  }

  /// This function does sends a message "hello!" to all peers.
  /// If you tap on an existing entity, it will run a scale up and down animation
  /// If you tap on the floor without hitting any entities it will create a new Anchor
  @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    guard let myData = "hello!".data(using: .ascii) else {
      return
    }
    multipeerHelp.sendToAllPeers(myData, reliably: true)

    guard let touchInView = sender?.location(in: self.arView) else {
      return
    }
    if let hitEntity = self.arView.entity(at: touchInView) {
      // animate the Entity
      hitEntity.runWithOwnerhsip { (result) in
        switch result {
        case .success:
          let origTransform = Transform(scale: .one, rotation: .init(), translation: .zero)
          let largerTransform = Transform(scale: .init(repeating: 1.5), rotation: .init(), translation: .zero)
          hitEntity.move(to: largerTransform, relativeTo: hitEntity.parent, duration: 0.2)
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            hitEntity.move(to: origTransform, relativeTo: hitEntity.parent, duration: 0.2)
          }
        case .failure:
          print("could not get access to entity")
        }
      }
    } else if let result = arView.raycast(
      from: touchInView,
      allowing: .existingPlaneGeometry, alignment: .horizontal
    ).first {
      self.addNewAnchor(transform: result.worldTransform)
    }
  }

  /// Add a new anchor to the session
  /// - Parameter transform: position in world space where the new anchor should be
  func addNewAnchor(transform: simd_float4x4) {
    let arAnchor = ARAnchor(name: "Cube Anchor", transform: transform)
    let newAnchor = AnchorEntity(anchor: arAnchor)

    let cubeModel = ModelEntity(
      mesh: .generateBox(size: 0.1),
      materials: [SimpleMaterial(color: .red, isMetallic: false)]
    )
    cubeModel.generateCollisionShapes(recursive: false)

    newAnchor.addChild(cubeModel)

    newAnchor.synchronization?.ownershipTransferMode = .autoAccept

    newAnchor.anchoring = AnchoringComponent(arAnchor)
    arView.scene.addAnchor(newAnchor)
    arView.session.add(anchor: arAnchor)

  }
}
