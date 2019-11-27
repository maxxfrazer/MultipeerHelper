//
//  MultipeerHelperDelegate.swift
//
//
//  Created by Max Cobb on 11/22/19.
//

import MultipeerConnectivity

public protocol MultipeerHelperDelegate: AnyObject {}

extension MultipeerHelperDelegate {
  /// Data that has been recieved from another peer
  /// - Parameters:
  ///     - data: The data which has been recieved
  ///     - peer: The peer that sent the data
  func receivedData(_ data: Data, _ peer: MCPeerID) {}

  /// Callback for when a peer joins the network
  /// - Parameter peer: the   `MCPeerID` of the newly joined peer
  func peerJoined(_ peer: MCPeerID) {}

  /// Callback for when a peer leaves the network
  /// - Parameter peer: the   `MCPeerID` of the peer that left
  func peerLeft(_ peer: MCPeerID) {}

  /// Callback for when a peer new peer has been found. will default to accept all peers
  /// - Parameter peer: the   `MCPeerID` of the peer who wants to join the network
  /// - Returns: Bool if the peer should be invited to the network or not
  func peerDiscovered(_ peer: MCPeerID) -> Bool { true }

  /// Peer can no longer be found on the network, and thus cannot receive data
  /// - Parameter peer: If a peer has left the network in a non typical way
  func peerLost(_ peer: MCPeerID) {}
  func receivedStream(_ stream: InputStream, _ streamName: String, _ peer: MCPeerID) {}
  func receivingResource(_ resourceName: String, _ peer: MCPeerID, _ progress: Progress) {}
  func receivedResource(_ resourceName: String, _ peer: MCPeerID, _ url: URL?, _ error: Error?) {}
}
