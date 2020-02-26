//
//  MenuItemTableViewController.swift
//  Ramen
//
//  Created by Bryan French on 12/16/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import UIKit

class MenuItemTableViewController: UITableViewController {
    
    var selectedMenu = MenuItem()
    var sceneDelegate: SceneDelegate!
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        itemName.text = selectedMenu.getName()
        itemDescription.text = selectedMenu.getDescript()
        itemPrice.text = String(format: "Price: $%0.2f", selectedMenu.getPrice())
        itemCategory.text = selectedMenu.getCategory()

        let url = URL(string: selectedMenu.getImageLink())
        let data =  try! Data(contentsOf: url!)
        itemImage.image = UIImage(data: data)
    }

    @IBAction func addToOrder(_ sender: UIButton) {
        //get existing first
        var orderRamens = UserDefaults.standard.array(forKey: "orders") as? [String] ?? []
        //store the item in the userdefaults array and set it
        orderRamens.append(selectedMenu.getName())
        UserDefaults.standard.set(orderRamens, forKey: "orders")
        sceneDelegate.tabBarController?.selectedIndex = 1
    }
}
