//
//  MyImageView.swift
//  My Tic Tac Toe
//
//  Created by Allan Shivji on 3/10/19.
//  Copyright © 2019 Allan Shivji. All rights reserved.
//

import UIKit

class MyImageView: UIImageView {

    var player:String?
    var activated:Bool! = false
    
    func settingPlayer(_player:String) {
        
        self.player = _player
        
        if activated == false {
            if _player == "x" {
                self.image = UIImage(named: "x")
            } else {
                self.image = UIImage(named: "o")
            }
            activated = true
        }
    }

}
