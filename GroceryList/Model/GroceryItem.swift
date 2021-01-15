//
//  GroceryItem.swift
//  GroceryList
//
//  Created by Omri Horowitz on 1/15/21.
//

import Foundation

class GroceryItem: Codable {
    
    var name: String
    var havePurchased: Bool
    
    init(name: String, havePurchased: Bool = false) {
        self.name = name
        self.havePurchased = havePurchased
    }
}

extension GroceryItem: Equatable {
    static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        return lhs.name == rhs.name && lhs.havePurchased == rhs.havePurchased
    }
}
