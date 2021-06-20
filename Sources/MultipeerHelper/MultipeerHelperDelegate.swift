//
//  MultipeerHelperDelegate.swift
//
//
//  Created by Max Cobb on 11/22/19.
//

import MultipeerConnectivity

/// Delegate for some useful multipeer connectivity methods
@objc public protocol MultipeerHelperDelegate: AnyObject {
  /// Data that has been recieved from another peer
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the multipeer connectivity
  ///   - data: The data which has been recieved
  ///   - peer: The peer that sent the data
  @objc optional func receivedData(peerHelper: MultipeerHelper, _ data: Data, _ peer: MCPeerID)

  /// Callback for when a peer joins the network
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the multipeer connectivity
  ///   - peer: the   `MCPeerID` of the newly joined peer
  @objc optional func peerJoined(peerHelper: MultipeerHelper, _ peer: MCPeerID)

  /// Callback for when a peer leaves the network
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the multipeer connectivity
  ///   - peer: the   `MCPeerID` of the peer that left
  @objc optional func peerLeft(peerHelper: MultipeerHelper, _ peer: MCPeerID)

  /// Callback for when a new peer has been found. will default to accept all peers
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the multipeer connectivity
  ///   - peer: the   `MCPeerID` of the peer who wants to join the network
  ///   - discoveryInfo: The info dictionary advertised by the discovered peer. For more information on the contents of this dictionary, see the documentation for
  ///  [init(peer:discoveryInfo:serviceType:)](apple-reference-documentation://ls%2Fdocumentation%2Fmultipeerconnectivity%2Fmcnearbyserviceadvertiser%2F1407102-init) in [MCNearbyServiceAdvertiser](apple-reference-documentation://ls%2Fdocumentation%2Fmultipeerconnectivity%2Fmcnearbyserviceadvertiser).
  /// - Returns: Bool if the peer request to join the network or not
  @objc optional func shouldSendJoinRequest(peerHelper: MultipeerHelper, _ peer: MCPeerID, with discoveryInfo: [String: String]?) -> Bool

  /// Handle when a peer has requested to join the network
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the multipeer connectivity
  ///   - peerID: Peer requesting to join
  ///   - context: Any data the requesting peer may have sent with their request
  /// - Returns: Bool if the peer's join request should be accepted
  @objc optional func shouldAcceptJoinRequest(peerHelper: MultipeerHelper, peerID: MCPeerID, context: Data?) -> Bool

  /// This will be set as the base for the discoveryInfo, which is sent out by the advertiser (host).
  /// The key "MultipeerHelper.compTokenKey" is in use by MultipeerHelper, for checking the
  /// compatibility of RealityKit versions.
  /// - Returns: Discovery Info
  @objc optional func setDiscoveryInfo() -> [String: String]

  /// Peer can no longer be found on the network, and thus cannot receive data
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the nearby peer whose state changed
  ///   - peer: If a peer has left the network in a non typical way
  @objc optional func peerLost(
    peerHelper: MultipeerHelper, _ peer: MCPeerID
  )

  /// Received a byte stream from remote peer.
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session through which the byte stream was opened
  ///   - stream: An NSInputStream object that represents the local endpoint for the byte stream.
  ///   - streamName: The name of the stream, as provided by the originator.
  ///   - peerID: The peer ID of the originator of the stream.
  @objc optional func receivedStream(
    peerHelper: MultipeerHelper, _ stream: InputStream, _ streamName: String, _ peer: MCPeerID
  )
  /// Start receiving a resource from remote peer.
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that started receiving the resource
  ///   - resourceName: name of the resource, as provided by the sender.
  ///   - peerID: sender’s peer ID.
  ///   - progress: NSProgress object that can be used to cancel the transfer or queried to determine how far the transfer has progressed.
  @objc optional func receivingResource(
    peerHelper: MultipeerHelper, _ resourceName: String, _ peer: MCPeerID, _ progress: Progress
  )
  /// Received a resource from remote peer.
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session through which the data were received
  ///   - resourceName: The name of the resource, as provided by the sender.
  ///   - peerID: The peer ID of the sender.
  ///   - localURL: An NSURL object that provides the location of a temporary file containing the received data.
  ///   - error: An error object indicating what went wrong if the file was not received successfully, or nil.
  @objc optional func receivedResource(
    peerHelper: MultipeerHelper, _ resourceName: String, _ peerID: MCPeerID, _ localUrl: URL?, _ error: Error?
  )
  /// Made first contact with peer and have identity information about the
  /// remote peer (certificate may be nil).
  /// - Parameters:
  ///   - peerHelper: The ``MultipeerHelper`` session that manages the nearby peer whose state changed
  ///   - certificate: A certificate chain, presented as an array of SecCertificateRef certificate objects. The first certificate in this chain is the peer’s certificate, which is derived from the identity that the peer provided when it called the `initWithPeer:securityIdentity:encryptionPreference:` method. The other certificates are the (optional) additional chain certificates provided in that same array.
  ///   If the nearby peer did not provide a security identity, then this parameter’s value is nil.
  ///   - peerID: The peer ID of the sender.
  @objc optional func receivedCertificate(
    peerHelper: MultipeerHelper, certificate: [Any]?, fromPeer peerID: MCPeerID) -> Bool
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
