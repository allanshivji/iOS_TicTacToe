//
//  ViewController.swift
//  My Tic Tac Toe
//
//  Created by Allan Shivji on 3/10/19.
//  Copyright © 2019 Allan Shivji. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class ViewController: UIViewController, MCBrowserViewControllerDelegate {
    
    

    @IBOutlet var xField: [MyImageView]!
    
    var appDelegate:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate.mpcHandling.gettingPeerConnection(displayName: UIDevice.current.name)
        appDelegate.mpcHandling.gettingSession()
        appDelegate.mpcHandling.showingSelf(show: true)
        
        //handling peer state notification
        
        NotificationCenter.default.addObserver(self, selector: "peerChangedNotification:", name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: Selector("handleReceivedNotification:"), name: NSNotification.Name(rawValue: "MPC_DidReceiveNotification"), object: nil)
        
        mainLogicField()
        
    }
    
    func peerChangedNotification(notification:NSNotification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        
        let state = userInfo.object(forKey: "state") as! Int
        
        if state != MCSessionState.connecting.rawValue{
            //Now we inform user that we have connected
            self.navigationItem.title = "Connected Successfully"
        }
    }
    
    
    @IBAction func getConnected(_ sender: Any) {
        
        if appDelegate.mpcHandling.gameSession != nil {
            appDelegate.mpcHandling.gettingBrowser()
            appDelegate.mpcHandling.browser.delegate = self
            
            self.present(appDelegate.mpcHandling.browser, animated: true, completion: nil
            )
            
        }
        
    }
    
    
    
    
    func mainLogicField() {
        for index in 0 ... xField.count - 1 {
            
            let recognizeGestureTouch = UITapGestureRecognizer(target: self, action: "fieldTapped")
            
            recognizeGestureTouch.numberOfTapsRequired = 1
            
            xField[index].addGestureRecognizer(recognizeGestureTouch)
        }
    }

    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        appDelegate.mpcHandling.browser.dismiss(animated: true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        appDelegate.mpcHandling.browser.dismiss(animated: true, completion: nil)
    }

}

