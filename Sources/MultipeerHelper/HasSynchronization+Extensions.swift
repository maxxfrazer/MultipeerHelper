//
//  HasSynchronization+Extensions.swift
//  MultipeerHelper+Example
//
//  Created by Max Cobb on 12/8/19.
//  Copyright © 2019 Max Cobb. All rights reserved.
//

#if !os(tvOS)
import RealityKit

/// Error enum for some common Multipeer Errors
public enum MHelperErrors: Error {
  /// Request timed out
  case timedOut
  /// Request failed
  case failure
}

@available(iOS 13.0, macOS 10.15, *)
public extension HasSynchronization {
  /// Execute the escaping completion if you are the entity owner, once you receive ownership
  /// or call result failure if ownership cannot be granted to the caller.
  /// - Parameter completion: completion of type Result, success once ownership granted, failure if not granted
  func runWithOwnership(
    completion: @escaping (Result<HasSynchronization, Error>) -> Void
  ) {
    if self.isOwner {
      // If caller is already the owner
      completion(.success(self))
    } else {
      self.requestOwnership { (result) in
        if result == .granted {
          completion(.success(self))
        } else {
          completion(
            .failure(result == .timedOut ?
              MHelperErrors.timedOut :
              MHelperErrors.failure
            )
          )
        }
      }
    }
  }
}
#endif
