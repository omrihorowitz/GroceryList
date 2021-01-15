//
//  GroceryListTableViewController.swift
//  GroceryList
//
//  Created by Omri Horowitz on 1/15/21.
//

import UIKit

class GroceryListTableViewController: UITableViewController {

    //MARK: - Properties
    
    var purchaseStatus = "needtopurchase"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroceryItemController.shared.loadFromPersistenceStore()
    }

    
    //MARK: - Actions
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add Grocery Item", message: "Watcha hungry for?", preferredStyle: .alert)
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (action) in
            guard let newGroceryItemName = alert.textFields?[0].text, !newGroceryItemName.isEmpty
            else { return }
            GroceryItemController.shared.createGroceryItemWith(name: newGroceryItemName)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { (_) in }
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        
        self.present(alert, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var items: [GroceryItem] = []
        if purchaseStatus == "needtopurchase" {
            for item in GroceryItemController.shared.myGroceryItems {
                if item.havePurchased == false {
                    items.append(item)
                }
            }
        } else {
            for item in GroceryItemController.shared.myGroceryItems {
                if item.havePurchased == true {
                    items.append(item)
                }
            }
        }
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var items: [GroceryItem] = []
        if purchaseStatus == "needtopurchase" {
            for item in GroceryItemController.shared.myGroceryItems {
                if item.havePurchased == false {
                    items.append(item)
                }
            }
        } else {
            for item in GroceryItemController.shared.myGroceryItems {
                if item.havePurchased == true {
                    items.append(item)
                }
            }
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groceryItemCell", for: indexPath) as? GroceryItemTableViewCell else { return UITableViewCell()}
        
        let selectedItems = items[indexPath.row]
        cell.updateWith(groceryItem: selectedItems)
        cell.delegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let groceryItemToDelete = GroceryItemController.shared.myGroceryItems[indexPath.row]
            GroceryItemController.shared.deleteGroceryItem(groceryItem: groceryItemToDelete); tableView.deleteRows(at: [indexPath], with: .fade)
        }    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFilterVC" {
            let destination = segue.destination as? FilterViewController
            destination?.delegate = self
        }
    }
}
    extension GroceryListTableViewController: GroceryListTableViewDelegate {
        func buttonTapped(sender: GroceryItemTableViewCell) {
            guard let indexPath = tableView.indexPath(for: sender) else { return }
            let groceryItemToToggle = GroceryItemController.shared.myGroceryItems[indexPath.row]
            GroceryItemController.shared.toggleDidPurchase(groceryItem: groceryItemToToggle)
            sender.updateWith(groceryItem: groceryItemToToggle)
        }
    }
    
extension GroceryListTableViewController: FilterSelectionDelegate {
    func purchaseStatus(status: String) {
        purchaseStatus = status
        tableView.reloadData()
    }
    
}
