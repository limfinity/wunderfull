//
//  Location.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import Foundation
import RealmSwift

enum Condition: String {
    
    case unacceptable = "UNACCEPTABLE"
    case good = "GOOD"
    
}

class Location: Object {
    
    dynamic var address = ""
    dynamic var coordinates: Coordinates?
    dynamic var engineType = ""
    dynamic var exterior = ""
    dynamic var fuel = 0
    dynamic var interior = ""
    dynamic var name = ""
    dynamic var vin = ""
    
    override static func primaryKey() -> String? {
        return "vin"
    }

}

