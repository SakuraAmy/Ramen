//
//  MenuItem.swift
//  Ramen
//
//  Created by Student on 12/10/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

class MenuItem: NSObject {
    
    private var name : String = ""
    private var descript : String = ""
    private var price : Double = 0
    private var category : String = ""
    private var imageName : String = ""
    private var imageLink : String = ""

    override var description : String {
        return "{\n\t Name: \(name)\n\t Description: \(descript)\n\t Price: \(price)\n\t Category: \(category)\n\t imageName: \(imageName)\n\t imageLink: \(imageLink)}"
    }
     
    init(name: String, descript: String, price: Double, category: String, imageName: String, imageLink: String) {
        super.init()
        self.set(name: name)
        self.set(descript: descript)
        self.set(price: price)
        self.set(category: category)
        self.set(imageName: imageName)
        self.set(imageLink: imageLink)
    }
    
    // Designated Initializer with default values
    override convenience init() {
        self.init(name: "Unknown", descript: "Unknown", price: 0.0, category: "Unknown", imageName: "Unknown", imageLink: "Unknown")
    }
    
    func getName() -> String {return name}
    func set(name: String) {
        let name = name
        
        if(name.count >= 3 && name.count < 75){
            self.name = name
        }else{
            self.name = "TBD"
            print("Bad value of ab in set(parkName): setting to TBD")
        }
    }
    func getDescript() -> String {return descript}
    func set(descript: String){self.descript = descript}
    func getPrice() -> Double {return price}
    func set(price: Double){self.price = price}
    func getCategory() -> String {return category}
    func set(category: String){self.category = category}
    func getImageName() -> String {return imageName}
    func set(imageName: String){self.imageName = imageName}
    func getImageLink() -> String {return imageLink}
    func set(imageLink: String){self.imageLink = imageLink}
}
