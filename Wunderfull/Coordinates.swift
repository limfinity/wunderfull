//
//  Coordinates.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import Foundation
import RealmSwift
import CoreLocation

class Coordinates: Object {
    
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    dynamic var foo = 0
    
    var clLocation: CLLocation {
        return CLLocation(latitude: latitude, longitude: longitude)
    }
    
}
