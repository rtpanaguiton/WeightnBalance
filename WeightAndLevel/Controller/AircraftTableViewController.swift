//
//  AircraftTypeTableViewController.swift
//  WeightAndLevel
//
//  Created by Reymund on 18/08/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import UIKit
import os.log
import RealmSwift

class AircraftTableViewController: UITableViewController {
 
    //MARK: Properties
    let realm = try! Realm()
  
    var aircraft: Results<Aircraft>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    
        
        let heli = realm.objects(Aircraft.self)
        if heli.count < 1 {
            loadSampleAircraft()
        } else {
            aircraft = realm.objects(Aircraft.self)
            tableView.reloadData()
        }
       
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aircraft?.count ?? 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            as? TableViewCell else {
                fatalError("The dequed cell is not an instance of MealTableViewCell")
        }
        if let aircraft = aircraft?[indexPath.row]{
            let photoImage = aircraft.photo
            cell.aircraftImage.image = UIImage(data: photoImage!, scale: 1.0)
            cell.aircraftType.text = aircraft.name
            cell.registrationNumber.text = aircraft.registrationNumber
        }
         return cell
    }
    //MARK: Action
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let aircraftForDeletion = self.aircraft?[indexPath.row] {
                
                try? self.realm.write {
                    self.realm.delete(aircraftForDeletion)
                }
                
            } else if editingStyle == .insert {
                
            }
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if segue.identifier == "inputWeightDetail" {
            guard let destinationVC = segue.destination as? ViewController else {
                fatalError("Unexpected destination. \(segue.destination)")
            }
            guard let selectedAircraftCell = sender as? TableViewCell else {
                fatalError("Unexpected sender, \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedAircraftCell) else {
                fatalError("The selected cell is not selected in the cell")
            }
            let selectedAircraft = aircraft?[indexPath.row]
            destinationVC.aircraft = selectedAircraft
            
        }
        else if segue.identifier == "checkDetail" {
            guard let destinationVC = segue.destination as? DetailsViewController else {
                fatalError("Unexpected destination. \(segue.destination)")
            }
            guard let indexPath = tableView.indexPathForSelectedRow else {
                fatalError("The selected row is not selected in the row")
            }
            let selectedAircraft = aircraft?[indexPath.row]
            destinationVC.aircraft = selectedAircraft
        }
        
    }
    
    
    @IBAction func unwindToAircraftList(_ sender: UIStoryboardSegue) {
        
        guard let sourceViewController = sender.source as? DetailsViewController, let aircraft = sourceViewController.aircraft else {
            fatalError("Nothing found")
        }
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            if let aircraftA = self.aircraft?[selectedIndexPath.row] {
            try! realm.write {
                aircraftA.name = aircraft.name
                aircraftA.centerOfGravity = aircraft.centerOfGravity
                aircraftA.emptyWeight = aircraft.emptyWeight
                aircraftA.registrationNumber = aircraft.registrationNumber
                aircraftA.photo = aircraft.photo
                }
            }
            
        }
        else {
            try! realm.write {
                realm.add(aircraft)
            }
        }
         tableView.reloadData()
    }

    
    func loadSampleAircraft() {

        let photo1 = UIImage(named: "Heli0")!
        let photo1Data = UIImagePNGRepresentation(photo1)!
        let photo2 = UIImage(named: "Heli1")
        let photo2Data = UIImagePNGRepresentation(photo2!)!
        let photo3 = UIImage(named: "Heli2")
        let photo3Data = UIImagePNGRepresentation(photo3!)!

        guard let aircraft1 = Aircraft(name: "EC120B", photo: photo1Data, registrationNumber: "9M-RSB", centerOfGravity: 1.2345, emptyWeight: 1005.0) else {
            fatalError("aircraft1 unable to instantiate")
        }

        guard let aircraft2 = Aircraft(name: "EC155B1", photo: photo2Data, registrationNumber: "9M-JTH", centerOfGravity: 2.4578, emptyWeight: 3500.0) else {
            fatalError("Aircraft2 unable to instantiate")
        }

        guard let aircraft3 = Aircraft(name: "BO105", photo: photo3Data, registrationNumber: "9M-LLE", centerOfGravity: 1.3458, emptyWeight: 2500.0) else {
            fatalError(" Unable to instantiate aircraft3")
        }

            try! realm.write {
                realm.add(aircraft1)
                realm.add(aircraft2)
                realm.add(aircraft3)
        }
        aircraft = realm.objects(Aircraft.self)
        tableView.reloadData()
    }

}
