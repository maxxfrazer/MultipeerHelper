//
//  RealityViewController.swift
//  MultipeerHelper+Example
//
//  Created by Max Cobb on 11/23/19.
//  Copyright © 2019 Max Cobb. All rights reserved.
//

import RealityKit
import FocusEntity
import ARKit
import MultipeerConnectivity

class RealityViewController: UIViewController, ARSessionDelegate {

  let arView = ARView(frame: .zero)
  let focusSquare = FESquare()
  var multipeerHelp: MultipeerHelper!
  required init() {
    super.init(nibName: nil, bundle: nil)
    setupARView()
    setupMultipeer()

    self.focusSquare.viewDelegate = self.arView
  }

  func session(_ session: ARSession, didUpdate frame: ARFrame) {
    self.focusSquare.updateFocusNode()
  }

  func setupARView() {
    arView.frame = self.view.bounds
    self.arView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

    arView.session.delegate = self

    let arConfiguration =  ARWorldTrackingConfiguration()
    arConfiguration.planeDetection = .horizontal
    arConfiguration.isCollaborationEnabled = true
    arView.session.run(arConfiguration, options: [])
    self.view.addSubview(arView)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension RealityViewController: MultipeerHelperDelegate {
  func setupMultipeer() {
    self.multipeerHelp = MultipeerHelper(
      serviceName: "helper-test",
      sessionType: .both,
      delegate: self
    )

    // MARK: - Setting RealityKit Synchronization
    guard let syncService = multipeerHelp.syncService else {
      fatalError("could not create multipeerHelp.syncService")
    }
    self.arView.scene.synchronizationService = syncService
  }
  func receivedData(_ data: Data, _ peer: MCPeerID) {
    print(String(data: data, encoding: .ascii) ?? "Data is not an ASCII string")
  }
  func peerJoined(_ peer: MCPeerID) {
    print("new peer has joined: \(peer.displayName)")
  }
}
