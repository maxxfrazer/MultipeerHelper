//
//  MultipeerHelperDelegate.swift
//  
//
//  Created by Max Cobb on 11/22/19.
//

import MultipeerConnectivity

public protocol MultipeerHelperDelegate: class {
  /// Data that has been recieved from another peer
  /// - Parameters:
  ///     - data: The data which has been recieved
  ///     - peer: The peer that sent the data
  func receivedData(_ data: Data, _ peer: MCPeerID)

  /// Callback for when a peer joins the network
  /// - Parameter peer: the   `MCPeerID` of the newly joined peer
  func peerJoined(_ peer: MCPeerID)

  /// Callback for when a peer leaves the network
  /// - Parameter peer: the   `MCPeerID` of the peer that left
  func peerLeft(_ peer: MCPeerID)

  /// Callback for when a peer new peer has been found. will default to accept all peers
  /// - Parameter peer: the   `MCPeerID` of the peer who wants to join the network
  /// - Returns: Bool if the peer should be invited to the network or not
  func peerDiscovered(_ peer: MCPeerID) -> Bool

  /// Peer can no longer be found on the network, and thus cannot receive data
  /// - Parameter peer: If a peer has left the network in a non typical way
  func peerLost(_ peer: MCPeerID)
  func receivedStream(_:InputStream, _:String, _:MCPeerID)
  func receivingResource(_:String, _:MCPeerID, _:Progress)
  func receivedResource(_:String, _:MCPeerID, _: URL?, _: Error?)
}

extension MultipeerHelperDelegate {
  func receivedData(_: Data, _: MCPeerID) {
    print("receivedData not implemented")
  }
  func peerJoined(_ :MCPeerID) {
    print("peerJoined not implemented")
  }
  func peerLeft(_ :MCPeerID) {
    print("peerLeft not implemented")
  }
  func peerDiscovered(_ :MCPeerID) -> Bool {
    print("peerDiscovered not implemented, default accepts")
    return true
  }
  func peerLost(_ :MCPeerID) {
    print("peerLost not implemented")
  }
  func receivedStream(_:InputStream, _:String, _:MCPeerID) {
    print("receivedStream not implemented")
  }
  func receivingResource(_: String, _: MCPeerID, _: Progress) {
    print("receivingResource not implemented")
  }
  func receivedResource(_: String, _: MCPeerID, _: URL?, _: Error?) {
    print("receivedResource not implemented")
  }
}
