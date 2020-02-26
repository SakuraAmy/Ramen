//
//  SceneDelegate.swift
//  Ramen
//
//  Created by Student on 12/10/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var vc : UIViewController?
    var tabBarController: UITabBarController?
    var menuItems:[MenuItem] = []

    func loadData() {
        do {
            
            let plistPath = Bundle.main.path(forResource: "ramens", ofType:  "plist")
           
            let data = try Data(contentsOf: URL(fileURLWithPath: plistPath!))
            
            let tempDict = try PropertyListSerialization.propertyList(from: data, format: nil) as! [String:Any]
            
            print("\(tempDict)")
            
            let tempArray = tempDict["ramens"]! as! Array<[String:Any]>
            
            for dict in tempArray {
                print("\(dict)")
                
                let name = dict["name"] as? String ?? "NO NAME"
                let descript = dict["description"]! as! String
                let price = dict["price"]! as! Double
                let category = dict["category"]! as! String
                let imageName = dict["imageName"]! as! String
                let imageLink = dict["imageLink"]! as! String
                let m = MenuItem(name: name, descript: descript, price: price, category: category, imageName: imageName, imageLink: imageLink)
                menuItems.append(m)
                
            }
            for m in menuItems {
                print("MenuItems: \(m)")
            }
        } catch {
            print(error)
        }
        print("There are \(menuItems.count) menu items")
        print("\(menuItems)")
    }


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        loadData()
        //var vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login") as! UINavigationController
        tabBarController = window?.rootViewController as? UITabBarController
        //vc = window?.rootViewController as? UINavigationController
        let vc2 = tabBarController?.viewControllers![0] as! UINavigationController
        let navVC = tabBarController?.viewControllers![0] as! UINavigationController
        let navVC2 = tabBarController?.viewControllers![1] as! UINavigationController
        let menuVC = navVC.viewControllers[0] as! MenuTableVC
        let orderVC = navVC2.viewControllers[0] as! OrderTableVC
        let menusList = MenuItems()
        menusList.menuList = menuItems
        menuVC.allMenuTable = menusList
        orderVC.allMenuTable = menusList
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

