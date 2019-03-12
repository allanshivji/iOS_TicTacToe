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
    }
    
    
    @IBAction func getConnected(_ sender: Any) {
        
        if appDelegate.mpcHandling.gameSession != nil {
            appDelegate.mpcHandling.gettingBrowser()
            appDelegate.mpcHandling.browser.delegate = self
            
            self.present(appDelegate.mpcHandling.browser, animated: true, completion: nil
            )
            
        }
        
    }
    
    
    
    
    func mainLogic() {
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

