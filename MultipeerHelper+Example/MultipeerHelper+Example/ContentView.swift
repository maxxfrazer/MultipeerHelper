//
//  ContentView.swift
//  MultipeerHelper+Example
//
//  Created by Max Cobb on 11/23/19.
//  Copyright © 2019 Max Cobb. All rights reserved.
//

import SwiftUI
import RealityKit
import ARKit
import FocusEntity
import SmartHitTest

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}


struct ARViewContainer: UIViewControllerRepresentable {

  func makeUIViewController(
    context: UIViewControllerRepresentableContext<
      ARViewContainer
    >
  ) -> RealityViewController {
    RealityViewController()
  }

  func updateUIViewController(
    _ uiViewController: RealityViewController,
    context: UIViewControllerRepresentableContext<
      ARViewContainer
    >
  ) {
  }

}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
