//
//  MultipeerHelperDelegate.swift
//  
//
//  Created by Max Cobb on 11/22/19.
//

import MultipeerConnectivity

public protocol MultipeerHelperDelegate {
  /// Data that has been recieved from another peer
  /// - Parameters:
  ///     - data: The data which has been recieved
  ///     - peer: The peer that sent the data
  func receivedData(_ data: Data, _ peer: MCPeerID) -> Void

  /// Callback for when a peer joins the network
  /// - Parameter peer: the   `MCPeerID` of the newly joined peer
  func peerJoined(_ peer: MCPeerID) -> Void

  /// Callback for when a peer leaves the network
  /// - Parameter peer: the   `MCPeerID` of the peer that left
  func peerLeft(_ peer: MCPeerID) -> Void

  /// Callback for when a peer new peer has been found. will default to accept all peers
  /// - Parameter peer: the   `MCPeerID` of the peer who wants to join the network
  /// - Returns: Bool if the peer should be invited to the network or not
  func peerDiscovered(_ peer: MCPeerID) -> Bool

  /// Peer can no longer be found on the network, and thus cannot receive data
  /// - Parameter peer: If a peer has left the network in a non typical way
  func peerLost(_ peer: MCPeerID) -> Void
  func receivedStream(_:InputStream, _:String, _:MCPeerID) -> Void
  func receivingResource(_:String, _:MCPeerID, _:Progress) -> Void
  func receivedResource(_:String, _:MCPeerID, _: URL?, _: Error?) -> Void
}

extension MultipeerHelperDelegate {
  func receivedData(_: Data, _: MCPeerID) -> Void {
    print("receivedData not implemented")
  }
  func peerJoined(_ :MCPeerID) -> Void {
    print("peerJoined not implemented")
  }
  func peerLeft(_ :MCPeerID) -> Void {
    print("peerLeft not implemented")
  }
  func peerDiscovered(_ :MCPeerID) -> Bool {
    print("peerDiscovered not implemented, default accepts")
    return true
  }
  func peerLost(_ :MCPeerID) -> Void {
    print("peerLost not implemented")
  }
  func receivedStream(_:InputStream, _:String, _:MCPeerID) -> Void {
    print("receivedStream not implemented")
  }
  func receivingResource(_: String, _: MCPeerID, _: Progress) -> Void {
    print("receivingResource not implemented")
  }
  func receivedResource(_: String, _: MCPeerID, _: URL?, _: Error?) -> Void {
    print("receivedResource not implemented")
  }
}

