//
//  RealmStore.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import Foundation
import RealmSwift

let realm = try! Realm()

extension Realm {
    
    func add(location: Location) {
        do {
            try write {
                add(location, update: true)
            }
        } catch let error {
            fatalError("Error saving location: \(error)")
        }
    }
    
    func getAllLocations() -> [Location] {
        return Array(objects(Location.self))
    }
    
}

