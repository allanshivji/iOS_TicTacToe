//
//  MultipeerConnectivityHandling.swift
//  My Tic Tac Toe
//
//  Created by Allan Shivji on 3/10/19.
//  Copyright © 2019 Allan Shivji. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class MultipeerConnectivityHandling: NSObject, MCSessionDelegate {

    //ID of devices in the network
    var pId:MCPeerID!
    var gameSession:MCSession!
    var browser:MCBrowserViewController!
    var showDevice:MCAdvertiserAssistant? = nil
    
    func gettingPeerConnection(displayName:String) {
        
        pId = MCPeerID(displayName: displayName)
        
    }
    
    func gettingSession() {
        gameSession = MCSession(peer: pId)
        gameSession.delegate = self
    }
    
    func gettingBrowser() {
        browser = MCBrowserViewController(serviceType: "myGame", session: gameSession)
    }
    
    func showingSelf(show:Bool) {
        if show {
            showDevice = MCAdvertiserAssistant(serviceType: "myGame", discoveryInfo: nil, session: gameSession)
            showDevice!.start()
        } else {
            showDevice!.stop()
            showDevice = nil
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        let gettingInfo = ["peersId":pId,"state":state.rawValue] as [String : Any]
//        dispatch_async(dispatch_get_main_queue(), {()->Void in
//
//            })
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil, userInfo: gettingInfo)
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        let gettingInfo = ["data":data, "peerId":peerID] as [String : Any]
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MPC_DidReceiveNotification"), object: nil, userInfo: gettingInfo)
        }
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    
    
}
