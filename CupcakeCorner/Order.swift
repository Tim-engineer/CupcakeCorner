//
//  Order.swift
//  CupcakeCorner
//
//  Created by Tim Matlak on 21/06/2024.
//

import Foundation

@Observable
class Order: Codable {
    // Custom coding keys for encoding/decoding
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
    
    // Order types available
    let types: [String]
    
    // Order details
    var type: Int
    var quantity: Int
    var specialRequestEnabled: Bool
    var extraFrosting: Bool
    var addSprinkles: Bool
    
    // Customer details
    var name: String
    var streetAddress: String
    var city: String
    var zip: String
    
    // Validation and cost
    var hasValidAddress: Bool
    var cost: Decimal
    
    // Initializer with default values
    init(
        types: [String] = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"],
        type: Int = 0,
        quantity: Int = 3,
        specialRequestEnabled: Bool = false,
        extraFrosting: Bool = false,
        addSprinkles: Bool = false,
        name: String = "",
        streetAddress: String = "",
        city: String = "",
        zip: String = "",
        hasValidAddress: Bool = false,
        cost: Decimal = Decimal(0)
    ) {
        self.types = types
        self.type = type
        self.quantity = quantity
        self.specialRequestEnabled = specialRequestEnabled
        self.extraFrosting = extraFrosting
        self.addSprinkles = addSprinkles
        self.name = name
        self.streetAddress = streetAddress
        self.city = city
        self.zip = zip
        self.hasValidAddress = hasValidAddress
        self.cost = cost
    }
}

