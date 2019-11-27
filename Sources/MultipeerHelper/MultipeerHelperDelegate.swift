//
//  MultipeerHelperDelegate.swift
//
//
//  Created by Max Cobb on 11/22/19.
//

import MultipeerConnectivity

@objc public protocol MultipeerHelperDelegate: AnyObject {
  /// Data that has been recieved from another peer
  /// - Parameters:
  ///     - data: The data which has been recieved
  ///     - peer: The peer that sent the data
  @objc optional func receivedData(_ data: Data, _ peer: MCPeerID)

  /// Callback for when a peer joins the network
  /// - Parameter peer: the   `MCPeerID` of the newly joined peer
  @objc optional func peerJoined(_ peer: MCPeerID)

  /// Callback for when a peer leaves the network
  /// - Parameter peer: the   `MCPeerID` of the peer that left
  @objc optional func peerLeft(_ peer: MCPeerID)

  /// Callback for when a peer new peer has been found. will default to accept all peers
  /// - Parameter peer: the   `MCPeerID` of the peer who wants to join the network
  /// - Returns: Bool if the peer should be invited to the network or not
  @objc optional func peerDiscovered(_ peer: MCPeerID) -> Bool

  /// Peer can no longer be found on the network, and thus cannot receive data
  /// - Parameter peer: If a peer has left the network in a non typical way
  @objc optional func peerLost(_ peer: MCPeerID)
  @objc optional func receivedStream(_ stream: InputStream, _ streamName: String, _ peer: MCPeerID)
  @objc optional func receivingResource(_ resourceName: String, _ peer: MCPeerID, _ progress: Progress)
  @objc optional func receivedResource(_ resourceName: String, _ peer: MCPeerID, _ url: URL?, _ error: Error?)
}
