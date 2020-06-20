//
//  ViewController.swift
//  ComparisonShopper
//
//  Created by Jay Strawn on 6/15/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Left
    @IBOutlet weak var titleLabelLeft: UILabel!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var priceLabelLeft: UILabel!
    @IBOutlet weak var roomLabelLeft: UILabel!
    
    // Right
    @IBOutlet weak var titleLabelRight: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var priceLabelRight: UILabel!
    @IBOutlet weak var roomLabelRight: UILabel!
    
    var house1: House?
    var house2: House?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        house1 = House()
        house1?.address = "Kathmandu, Nepal"
        house1?.price = "12000"
        house1?.bedrooms = "3"
        
        setUpLeftSideUI()
        setUpRightSideUI()
    }
    
    func setUpLeftSideUI() {
        guard let houseInstance = house1 else { return }
        titleLabelLeft.text = houseInstance.address
        priceLabelLeft.text = houseInstance.price == nil ? "" : "$\(houseInstance.price!)"
        roomLabelLeft.text = houseInstance.bedrooms == nil ? "" : "\(houseInstance.bedrooms!) bedrooms"
    }
    
    func setUpRightSideUI() {
        guard let houseInstance = house2 else {
            titleLabelRight.alpha = 0
            imageViewRight.alpha = 0
            priceLabelRight.alpha = 0
            roomLabelRight.alpha = 0
            return
        }
        
        if houseInstance.address == "" && houseInstance.price == "" && houseInstance.bedrooms == "" {
            showAlertWithOk(with: "Comparison Shopper - Error",
                            and: "You haven't entered any house details.") {
                                self.openAlertView()
            }
            return
        }
        
        titleLabelRight.text = houseInstance.address
        priceLabelRight.text = houseInstance.price == "" ? "" : "$\(houseInstance.price!)"
        roomLabelRight.text = houseInstance.bedrooms == "" ? "" : "\(houseInstance.bedrooms!) bedrooms"
        titleLabelRight.alpha = 1
        imageViewRight.alpha = 1
        priceLabelRight.alpha = 1
        roomLabelRight.alpha = 1
    }
    
    @IBAction func didPressAddRightHouseButton(_ sender: Any) {
        openAlertView()
    }
    
    func openAlertView() {
        let alert = UIAlertController(title: "Add Right Item",
                                      message: "Enter the house details:",
                                      preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "address"
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "price"
            textField.keyboardType = .decimalPad
        }
        
        alert.addTextField { (textField) in
            textField.placeholder = "bedrooms"
            textField.keyboardType = .numberPad
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:{ (UIAlertAction) in
            var house = House()
            house.address = alert.textFields?[0].text
            house.price = alert.textFields?[1].text
            house.bedrooms = alert.textFields?[2].text
            self.house2 = house
            self.setUpRightSideUI()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

struct House {
    var address: String?
    var price: String?
    var bedrooms: String?
}

