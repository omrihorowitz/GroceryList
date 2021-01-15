//
//  FilterViewController.swift
//  GroceryList
//
//  Created by Omri Horowitz on 1/15/21.
//

import UIKit

protocol FilterSelectionDelegate: AnyObject {
    func purchaseStatus(status: String)
}

class FilterViewController: UIViewController {
    
    weak var delegate: FilterSelectionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func needToPurchaseButtonTapped(_ sender: Any) {
        delegate?.purchaseStatus(status: "needtopurchase")
        self.dismiss(animated: true)
    }
    
    @IBAction func alreadyPurchaedButtonTapped(_ sender: Any) {
        delegate?.purchaseStatus(status: "purchased")
        self.dismiss(animated: true)
    }
}
