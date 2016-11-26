//
//  NetworkLayer.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import Foundation
import Alamofire

typealias JSON = [String: AnyObject]

struct WunderAPI {
    
    static func getLocations() {
        Alamofire.request("https://s3-us-west-2.amazonaws.com/wunderbucket/locations.json").responseJSON { response in
            guard let json = response.result.value as? JSON else {
                return print("Could not retrieve value from JSON repsonse")
            }
            guard let placemarkArray = json["placemarks"] as? [JSON] else {
                return print("Could not retrieve placemarks from JSON")
            }
            let methodStart = Date()
            placemarkArray.forEach { placemark in
                realm.add(location: Location(value: placemark))
            }
            let methodFinish = Date()
            let executionTime = methodFinish.timeIntervalSince(methodStart)
            print("Execution time to add/update placemarks to realm database: \(executionTime)")
        }
    }
    
}
