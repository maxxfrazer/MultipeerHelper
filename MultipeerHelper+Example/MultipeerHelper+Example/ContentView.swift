//
//  ContentView.swift
//  MultipeerHelper+Example
//
//  Created by Max Cobb on 11/23/19.
//  Copyright © 2019 Max Cobb. All rights reserved.
//

import ARKit
import FocusEntity
import RealityKit
import SmartHitTest
import SwiftUI

struct ContentView: View {
  var body: some View {
    ARViewContainer().edgesIgnoringSafeArea(.all)
  }
}

struct ARViewContainer: UIViewControllerRepresentable {
  func makeUIViewController(
    context _: UIViewControllerRepresentableContext<
    ARViewContainer
    >
  ) -> RealityViewController {
    RealityViewController()
  }

  func updateUIViewController(
    _: RealityViewController,
    context _: UIViewControllerRepresentableContext<
    ARViewContainer
    >
  ) {}
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
#endif
