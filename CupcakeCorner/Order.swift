//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tim Matlak on 21/06/2024.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || streetAddress.hasPrefix(" ") || city.isEmpty || zip.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Decimal {
        // $2 per cake
        var cost = Decimal(quantity) * 2

        // complicated cakes cost more
        cost += Decimal(type) / 2

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }

        return cost
    }
    
    // Save to UserDefaults
        func saveToUserDefaults() {
            let defaults = UserDefaults.standard
            defaults.set(name, forKey: "name")
            defaults.set(streetAddress, forKey: "streetAddress")
            defaults.set(city, forKey: "city")
            defaults.set(zip, forKey: "zip")
        }
        
        // Load from UserDefaults
        func loadFromUserDefaults() {
            let defaults = UserDefaults.standard
            name = defaults.string(forKey: "name") ?? ""
            streetAddress = defaults.string(forKey: "streetAddress") ?? ""
            city = defaults.string(forKey: "city") ?? ""
            zip = defaults.string(forKey: "zip") ?? ""
        }
}
