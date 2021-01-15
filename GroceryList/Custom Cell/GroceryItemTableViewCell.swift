//
//  GroceryItemTableViewCell.swift
//  GroceryList
//
//  Created by Omri Horowitz on 1/15/21.
//

import UIKit

protocol GroceryListTableViewDelegate: AnyObject {
    func buttonTapped(sender: GroceryItemTableViewCell)
}

class GroceryItemTableViewCell: UITableViewCell {

    //MARK: - Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var havePurchasedButton: UIButton!
    
    
    //MARK: - Properties
    
    weak var delegate: GroceryListTableViewDelegate?
    
    //MARK: - Actions

    @IBAction func havePurchasedButtonTapped(_ sender: Any) {
        delegate?.buttonTapped(sender: self)
    }
    
    //MARK: - Methods
    
    func updateWith(groceryItem: GroceryItem) {
        nameLabel.text = groceryItem.name
        updateButtonStatusWith(havePurchased: groceryItem.havePurchased)
    }
        
    func updateButtonStatusWith(havePurchased: Bool) {
        let imageName = havePurchased ? "complete" : "incomplete"
        havePurchasedButton.setBackgroundImage(UIImage(named: imageName), for: .normal)
    }
}
