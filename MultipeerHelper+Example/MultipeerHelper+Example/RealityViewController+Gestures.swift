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

extension RealityViewController {
  /// This function does two things. Sends a message "hello!" to all peers, and also adds a cube
  /// at the touch location
  override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
    guard let myData = "hello!".data(using: .ascii) else {
      return
    }
    multipeerHelp.sendToAllPeers(myData, reliably: true)

    guard let touchInView = touches.first?.location(in: self.arView) else {
      return
    }

    guard let result = arView.raycast(
      from: touchInView,
      allowing: .existingPlaneGeometry, alignment: .horizontal
    ).first else {
      return
    }

    let arAnchor = ARAnchor(name: "Cube Anchor", transform: result.worldTransform)
    let newAnchor = AnchorEntity(anchor: arAnchor)

    let cubeModel = ModelEntity(
      mesh: .generateBox(size: 0.1),
      materials: [SimpleMaterial(color: .red, isMetallic: false)]
    )
    newAnchor.addChild(cubeModel)

    newAnchor.synchronization?.ownershipTransferMode = .autoAccept

    newAnchor.anchoring = AnchoringComponent(arAnchor)
    arView.scene.addAnchor(newAnchor)
    arView.session.add(anchor: arAnchor)
  }
}
