//
//  AppDelegate.swift
//  MultipeerHelper+Example
//
//  Created by Max Cobb on 11/23/19.
//  Copyright © 2019 Max Cobb. All rights reserved.
//

import SwiftUI
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(
    _: UIApplication,
    didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Create the SwiftUI view that provides the window contents.
    let contentView = ContentView()

    // Use a UIHostingController as window root view controller.
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UIHostingController(rootView: contentView)
    self.window = window
    window.makeKeyAndVisible()
    return true
  }
}
