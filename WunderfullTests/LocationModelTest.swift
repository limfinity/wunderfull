//
//  WunderfullTests.swift
//  WunderfullTests
//
//  Created by Peter Pult on 25/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import XCTest
@testable import Wunderfull

class LocationModelTest: XCTestCase {
    
    let stubLocation = [
        "address": "Lesserstraße 170, 22049 Hamburg",
        "coordinates": [
            10.07526,
            53.59301,
            0
        ],
        "engineType": "CE",
        "exterior": "UNACCEPTABLE",
        "fuel": 42,
        "interior": "UNACCEPTABLE",
        "name": "HH-GO8522",
        "vin": "WME4513341K565439"
    ] as [String : Any]
    
    var location: Location!
    
    override func setUp() {
        super.setUp()
    
        // Create new location from stub data for each test
        location = Location(value: stubLocation)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocationInitialization() {
        XCTAssertNotNil(location, "Location object should not be nil")
    }
    
    func testLocationStringValue() {
        XCTAssertEqual(location.address, "Lesserstraße 170, 22049 Hamburg", "Location address should be \("Lesserstraße 170, 22049 Hamburg")")
    }
    
    func testLocationIntValue() {
        XCTAssertEqual(location.fuel, 42, "Location fuel should be \(42)")
    }
    
    func testLocationCoordinates() {
        let coordinates = location.coordinates
        XCTAssertNotNil(coordinates, "Location coordinates should not be nil")
    }
    
}
