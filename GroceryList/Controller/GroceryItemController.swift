//
//  GroceryItemController.swift
//  GroceryList
//
//  Created by Omri Horowitz on 1/15/21.
//

import Foundation

class GroceryItemController {
    
    //MARK: - Properties
    
    static let shared = GroceryItemController()
    
    var myGroceryItems: [GroceryItem] = []
    
    //MARK: - CRUD
    
    func createGroceryItemWith(name: String) {
        let newGroceryItem = GroceryItem(name: name)
        myGroceryItems.append(newGroceryItem)
        saveToPersistenceStore()
    }
    
    func deleteGroceryItem(groceryItem: GroceryItem) {
        guard let indexToDelete = myGroceryItems.firstIndex(of: groceryItem) else { return }
        myGroceryItems.remove(at: indexToDelete)
        saveToPersistenceStore()
    }
    
    func toggleDidPurchase(groceryItem: GroceryItem) {
        groceryItem.havePurchased = !groceryItem.havePurchased
        saveToPersistenceStore()
    }
    
    //MARK: - Persistence
    
    // file URL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("GroceryList.json")
        return fileURL
    }
    
    // save
    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(myGroceryItems)
            try data.write(to: fileURL())
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
    
    // load
    func loadFromPersistenceStore() {
        do {
            let data = try Data(contentsOf: fileURL())
            let foundGroceries = try JSONDecoder().decode([GroceryItem].self, from: data)
            myGroceryItems = foundGroceries
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }

}
