//
//  ViewController.swift
//  WeightAndLevel
//
//  Created by Reymund on 14/08/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import UIKit
import os.log
import RealmSwift

class ViewController: UIViewController, UITextViewDelegate, UITabBarDelegate  {
    
    let realm = try! Realm()
    var weightDetail: Results<WeightDetail>?
    var aircraft: Aircraft?

    lazy var computation = Computation(aircraftWeight: (aircraft?.emptyWeight)!, aircraftCG: (aircraft?.centerOfGravity)! )
    @IBOutlet weak var coPilotWeight: UITextView!  { didSet { try! realm.write {
        weightDetail?.first?.coPilotWeight = Double(coPilotWeight.text)!
        print(weightDetail?.count ?? 0)
        }}}
    @IBOutlet weak var pilotWeight: UITextView! { didSet { try! realm.write {
        weightDetail?.first?.pilotWeight = Double(pilotWeight.text)!
         print(pilotWeight.text)
        }}}
    @IBOutlet weak var pax1Weight: UITextView! { didSet { try! realm.write {
        weightDetail?.first?.pax1Weight = Double(pax1Weight.text)!
         print(pax1Weight.text)
        }}}
    @IBOutlet weak var pax2Weight: UITextView! { didSet { try! realm.write {
        weightDetail?.first?.pax2Weight = Double(pax2Weight.text)!
         print(pax2Weight.text)
        }}}
    @IBOutlet weak var pax3Weight: UITextView! { didSet { try! realm.write {
        weightDetail?.first?.pax3Weight = Double(pax3Weight.text)!
         print(pax3Weight.text)
        }}}
    @IBOutlet weak var fuelWeight: UITextView! { didSet { try! realm.write {
        weightDetail?.first?.fuelWeight = Double(fuelWeight.text)!
         print(fuelWeight.text)
        }}}
    @IBOutlet weak var baggageWeight: UITextView! { didSet { try! realm.write {
        weightDetail?.first?.baggageWeight = Double(baggageWeight.text)!
         print(baggageWeight.text)
        }}}
    
    
    @IBOutlet weak var totalWeightLabel: UILabel!

    @IBOutlet weak var centerOfGravityLabel: UILabel!
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let weightDetail1 = realm.objects(WeightDetail.self)
//        if weightDetail1.count < 1 {

        loadSampleWeight()
        
//        } else {
//            weightDetail = realm.objects(WeightDetail.self)
//        }
        
        updateWeightLabels()
        
        updateTotalWeightLabel()
        
        print(weightDetail?.count ?? 0)
        
        pilotWeight.delegate = self
        coPilotWeight.delegate = self
        pax1Weight.delegate = self
        pax2Weight.delegate = self
        pax3Weight.delegate = self
        baggageWeight.delegate = self
        fuelWeight.delegate = self

    }
    
  
    
    func saveInputtedText(number : Double) {
        
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }
   
    @IBAction func showResult(_ sender: UIButton) {
        centerOfGravityLabel.text = "CG: \(computation.computeForCenterOfGravity().rounded(toPlaces: 4))"
    }
    
    func updateTotalWeightLabel() {
        let computedTotalWeight = computation.computeForTotalWeight()
        let overweight = computedTotalWeight - 1715.0
        totalWeightLabel.text = "Total Weight: \(computedTotalWeight)"
        if computedTotalWeight < 1715.0 {
            totalWeightLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else {
            totalWeightLabel.textColor =  #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            totalWeightLabel.text = "Total Weight: \(computedTotalWeight)(\(overweight))"
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let weight = weightDetail?.first {
            computation.coPilotWeight = weight.coPilotWeight
            computation.pilotWeight = weight.pilotWeight
            computation.pax1Weight = weight.pax1Weight
            computation.pax2Weight = weight.pax2Weight
            computation.pax3Weight = weight.pax3Weight
            computation.fuelWeight = weight.fuelWeight
            computation.baggageWeight = weight.baggageWeight
        }
        updateTotalWeightLabel()

        print(computation.coPilotWeight)
        print(computation.pilotWeight)
        print(computation.pax1Weight)
        print(computation.pax2Weight)
        print(computation.pax3Weight)
        print(computation.fuelWeight)
        print(computation.baggageWeight)
        print(computation.aircraftWeight)
        print(computation.computeForTotalWeight())
        self.view.endEditing(true)
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        
        let isPresentingMode = presentingViewController is UINavigationController
        
        if isPresentingMode {
            
            dismiss(animated: true, completion: nil)
            
        } else if let owningNavigationController =  navigationController {
            
            owningNavigationController.popViewController(animated: true)
            
        } else {
            
            fatalError("The ViewController is not inside a navigation controller")
        }
    
    }
    
    private func updateWeightLabels() {
        if let weight = weightDetail?.first {
        pilotWeight.text = String(weight.pilotWeight)
        coPilotWeight.text = String(weight.coPilotWeight)
        pax1Weight.text = String(weight.pax1Weight)
        pax2Weight.text = String(weight.pax2Weight)
        pax3Weight.text = String(weight.pax3Weight)
        baggageWeight.text = String(weight.baggageWeight)
        fuelWeight.text = String(weight.fuelWeight)
        }
    }
    
    func loadSampleWeight() {
        
        
        let weightDetailSample = WeightDetail()
        weightDetailSample.pilotWeight = 66.0
        weightDetailSample.coPilotWeight = 87.0
        weightDetailSample.pax1Weight = 76.0
        weightDetailSample.pax2Weight = 88.0
        weightDetailSample.pax3Weight = 84.0
        weightDetailSample.baggageWeight = 22.0
        weightDetailSample.fuelWeight = 250.0
        
        try! realm.write {
            realm.add(weightDetailSample)
        }
    }
    
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

