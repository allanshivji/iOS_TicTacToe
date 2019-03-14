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
    
    var currentTap:String!
    
    var appDelegate:AppDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        appDelegate.mpcHandling.gettingPeerConnection(displayName: UIDevice.current.name)
        appDelegate.mpcHandling.gettingSession()
        appDelegate.mpcHandling.showingSelf(show: true)
        
        //handling peer state notification
        
        NotificationCenter.default.addObserver(self, selector: #selector(peerChangedNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidChangeStateNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleReceivedNotification(notification:)), name: NSNotification.Name(rawValue: "MPC_DidReceiveNotification"), object: nil)
        
        mainLogicField()
        currentTap = "x"
    }
    
    @objc func peerChangedNotification(notification:NSNotification){
        let userInfo = NSDictionary(dictionary: notification.userInfo!)
        
        let state = userInfo.object(forKey: "state") as! Int
        
        if state != MCSessionState.connecting.rawValue{
            //Now we inform user that we have connected
            self.navigationItem.title = "Connected"
        }
    }
    
    @objc func handleReceivedNotification(notification:NSNotification){
        
    }
    
    
    
    @IBAction func getConnected(_ sender: Any) {
        
        if appDelegate.mpcHandling.gameSession != nil {
            appDelegate.mpcHandling.gettingBrowser()
            appDelegate.mpcHandling.browser.delegate = self
            
            self.present(appDelegate.mpcHandling.browser, animated: true, completion: nil
            )
            
        }
        
    }
    
    @objc func imageTapped(recognizer:UITapGestureRecognizer){
        
        let tappedImage = recognizer.view as! MyImageView
        tappedImage.settingPlayer(_player: currentTap)
        
        //To know o nother device if tapped is done or not
        
        //create dictionary
        let sendMessageOtherDevice = ["field":tappedImage.tag, "player":currentTap] as [String : Any]
        
        //preper NSData to send as directly dictionary cannot be sent
        do{
            let messageData = try JSONSerialization.data(withJSONObject: sendMessageOtherDevice, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch {
            print(Error.self)
        }
        
        
        
    }
    
    
    func mainLogicField() {
        for index in 0 ... xField.count - 1 {
            
            let recognizeGestureTouch = UITapGestureRecognizer(target: self, action: #selector(imageTapped(recognizer:)))
            
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

