//
//  MenuTableViewController.swift
//  Ramen
//
//  Created by Student on 12/13/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import Foundation
import UIKit

class MenuTableVC: UITableViewController {
    
    var selectedMenu = MenuItem()
    var allMenuTable = MenuItems()
    var menuTable : [MenuItem] {
        get {
            return self.allMenuTable.menuList
        }
        set(val) {
            self.allMenuTable.menuList = val
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sceneDelegate = self.navigationController?.viewControllers[0].view.window?.windowScene?.delegate as! SceneDelegate
       let destinationViewController = segue.destination as! MenuItemTableViewController
        let indexPath = tableView.indexPathForSelectedRow
        destinationViewController.selectedMenu = menuTable[indexPath!.row]
        destinationViewController.sceneDelegate = sceneDelegate
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationItem.backBarButtonItem = backButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuTable.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)

        cell.textLabel?.text = menuTable[indexPath.row].getName()
        //cell.textLabel?.text = String(format: "Price: $%0.2f", menuTable[indexPath.row].getPrice())
        
        let url = URL(string: menuTable[indexPath.row].getImageLink())
        let data =  try! Data(contentsOf: url!)
        cell.imageView?.image = UIImage(data: data)


        return cell
    }
}
