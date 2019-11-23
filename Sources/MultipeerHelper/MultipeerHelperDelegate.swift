//
//  MultipeerHelperDelegate.swift
//  
//
//  Created by Max Cobb on 11/22/19.
//

import MultipeerConnectivity

public protocol MultipeerHelperDelegate {
  func receivedData(_: Data, _: MCPeerID) -> Void
  func peerJoined(_ :MCPeerID) -> Void
  func peerLeft(_ :MCPeerID) -> Void
  func peerDiscovered(_ :MCPeerID) -> Bool
  func peerLost(_ :MCPeerID) -> Void
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

