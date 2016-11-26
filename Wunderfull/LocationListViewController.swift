//
//  LocationListViewController.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import UIKit

class LocationListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    fileprivate var locations = realm.getAllLocations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Location cound on load \(locations.count)")
        
        WunderAPI.getLocations()
    }
    
}

extension LocationListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationListCell", for: indexPath) as! LocationListTableViewCell
        let location = locations[indexPath.row]
        cell.nameLabel.text = location.name
        cell.addressLabel.text = location.address
        cell.fuelProgressView.progress = Float(location.fuel) / 100
        return cell
    }
    
}
