//
//  OrderConfirmationViewController.swift
//  Ramen
//
//  Created by Student on 12/13/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import UIKit

class OrderConfirmationVC: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    var selectedMenu = MenuItem()
    var sceneDelegate: SceneDelegate!
    
    var minutes: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // see if s at the end needs to be used for plural
        let s = minutes! == 1 ? "" : "s"

        // message to the user with the time remaining
        timeLabel.text = "Thank you for your order!  Your wait time is approximatly \(minutes!) minute\(s)."
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
