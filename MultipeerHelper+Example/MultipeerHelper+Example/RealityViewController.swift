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

class RealityViewController: UIViewController {

  let arView = ARView(frame: .zero)
  let focusSquare = FESquare()
  required init() {
    super.init(nibName: nil, bundle: nil)
    arView.frame = self.view.bounds
    self.arView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    arView.automaticallyConfigureSession = false
    let arConfiguration =  ARWorldTrackingConfiguration()
    arConfiguration.planeDetection = .horizontal
    arConfiguration.isCollaborationEnabled = true

    arView.session.run(arConfiguration, options: [])
    self.view.addSubview(arView)
    self.focusSquare.viewDelegate = self.arView

  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
