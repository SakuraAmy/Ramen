//
//  OrderTableViewController.swift
//  Ramen
//
//  Created by Student on 12/13/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import Foundation
import UIKit

class OrderTableVC: UITableViewController {
    
    var orderRamens : [String] = []
    var orderMinutes = 0
    var allMenuTable = MenuItems()
    var selectedMenu = MenuItem()
    var menuTable : [MenuItem] {
        get {
            return self.allMenuTable.menuList
        }
        set(val) {
            self.allMenuTable.menuList = val
        }
    }
    override func viewDidLoad() {
        self.isEditing = false
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.isEditing = false
        orderRamens = UserDefaults.standard.array(forKey: "orders") as? [String] ?? []
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderRamens.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderTableCell", for: indexPath)

        //search through menuTable array for name == orderRamens[indexPath.row]
        let menuItem = menuTable.filter{ $0.getName() == orderRamens[indexPath.row] }.first
        if menuItem != nil {
            //get it's price and set cell label to that
            let temp = menuItem?.getPrice()
            cell.detailTextLabel?.text = String(format: "Price: $%0.2f", temp!)
            //now do the image
            let url = URL(string: menuItem!.getImageLink())
            let data =  try! Data(contentsOf: url!)
            cell.imageView?.image = UIImage(data: data)
        }
        cell.textLabel?.text = orderRamens[indexPath.row]

        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            orderRamens.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
        
        var array = UserDefaults.standard.array(forKey: "orders") as? [String]
        if array != nil {
        if (array?.contains((array?[indexPath.row])!))! {
            array!.remove(at: indexPath.row)
        }
        }
        UserDefaults.standard.set(array, forKey:"orders")

    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = orderRamens[fromIndexPath.row]
        orderRamens.remove(at: fromIndexPath.row)
        orderRamens.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    
    @IBAction func submit(_ sender: UIBarButtonItem) {
        
        var orderTotal = 0.0
        for item in orderRamens {
        //find the menu item in orderRamens
            let menuItem = menuTable.filter{ $0.getName() == item }.first
            if menuItem != nil {
                //get it's price and add to the total
                orderTotal += menuItem!.getPrice()
            }
        }
        
        // format the order total price
        let formattedOrder = String(format: "$%2.f", orderTotal)
        
        // prepare an alert for the user
        let alert = UIAlertController(
            title: "Confirm Order",
            message: "You are about to submit your order with a total of \(formattedOrder)",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Submit", style: .default) { action in
            self.uploadOrder()
        })
        
        // add cancel on dismiss
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // present the alert for the user about order submission
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "DismissConfirmation" {
            // clear order menu items
            orderRamens.removeAll()
            
            // reload the table to show empty list
            tableView.reloadData()
            
            // update the number of items in the order list
            updateBadgeNumber()
        }
    }
    
    func uploadOrder() {
        
        for item in orderRamens {
            //find the menu item in orderRamens
            let menuItem = menuTable.filter{ $0.getName() == item }.first
            if menuItem != nil {
                //get it's id? and do something with it?
            }
        }
        
        //perform the segue to confirmation screen
        self.performSegue(withIdentifier: "ConfirmationSegue", sender: nil)
    }
    
//    func added(selectedMenu = menuTable[indexPath!.row]) {
//
//    }
    
    func updateBadgeNumber() {
        // get the number of items in the order
        let badgeValue = 0 < orderRamens.count ? "\(orderRamens.count)" : nil
        
        // assign the badge value to the order tab
        navigationController?.tabBarItem.badgeValue = badgeValue
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ConfirmationSegue" {
            let orderConfirmationViewController = segue.destination as! OrderConfirmationVC
            
            orderConfirmationViewController.minutes = orderMinutes
        }
        
    }
}
