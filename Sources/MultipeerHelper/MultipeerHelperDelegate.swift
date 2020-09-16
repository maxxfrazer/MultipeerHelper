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

  /// Callback for when a new peer has been found. will default to accept all peers
  /// - Parameter peer: the   `MCPeerID` of the peer who wants to join the network
  /// - Parameter discoveryInfo: The info dictionary advertised by the discovered peer. For more information on the contents of this dictionary, see the documentation for
  ///  [init(peer:discoveryInfo:serviceType:)](apple-reference-documentation://ls%2Fdocumentation%2Fmultipeerconnectivity%2Fmcnearbyserviceadvertiser%2F1407102-init) in [MCNearbyServiceAdvertiser](apple-reference-documentation://ls%2Fdocumentation%2Fmultipeerconnectivity%2Fmcnearbyserviceadvertiser).
  /// - Returns: Bool if the peer request to join the network or not
  @objc optional func shouldSendJoinRequest(_ peer: MCPeerID, with discoveryInfo: [String: String]?) -> Bool

  /// Handle when a peer has requested to join the network
  /// - Parameters:
  ///   - peerID: Peer requesting to join
  ///   - context: Any data the requesting peer may have sent with their request
  /// - Returns: Bool if the peer's join request should be accepted
  @objc optional func shouldAcceptJoinRequest(peerID: MCPeerID, context: Data?) -> Bool

  /// This will be set as the base for the discoveryInfo, which is sent out by the advertiser (host).
  /// The key "MultipeerHelper.compTokenKey" is in use by MultipeerHelper, for checking the
  /// compatibility of RealityKit versions.
  @objc optional func setDiscoveryInfo() -> [String: String]

  /// Peer can no longer be found on the network, and thus cannot receive data
  /// - Parameter peer: If a peer has left the network in a non typical way
  @objc optional func peerLost(_ peer: MCPeerID)
  @objc optional func receivedStream(_ stream: InputStream, _ streamName: String, _ peer: MCPeerID)
  @objc optional func receivingResource(_ resourceName: String, _ peer: MCPeerID, _ progress: Progress)
  @objc optional func receivedResource(_ resourceName: String, _ peer: MCPeerID, _ url: URL?, _ error: Error?)
  @objc optional func receivedCertificate(certificate: [Any]?, fromPeer peerID: MCPeerID) -> Bool
}

#if canImport(RealityKit)
import RealityKit
extension MultipeerHelperDelegate {
  /// Checks whether the discovered session is using a compatible version of RealityKit
  /// For collaborative sessions.
  /// - Parameter discoveryInfo: The discoveryInfo from the advertiser
  /// picked up by a browser.
  /// - Returns: Boolean representing whether or not the two devices
  /// have compatible versions of RealityKit.
  public static func checkPeerToken(with discoveryInfo: [String: String]?) -> Bool {
    guard let compTokenStr = discoveryInfo?[MultipeerHelper.compTokenKey]
          else {
      return false
    }
    if #available(iOS 13.4, macOS 10.15.4, *) {
      if let tokenData = compTokenStr.data(using: .utf8),
         let compToken = try? JSONDecoder().decode(
          NetworkCompatibilityToken.self,
          from: tokenData
      ) {
        return compToken.compatibilityWith(.local) == .compatible
      }
    }
    return false
  }
}
#endif
