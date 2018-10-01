//
//  Aircraft.swift
//  WeightAndLevel
//
//  Created by Reymund on 10/09/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import UIKit
import os.log
import RealmSwift

class Aircraft: Object {
    
    //MARK: - Properties
    
    @objc dynamic var name: String = ""
    @objc dynamic var photo: Data?
    @objc dynamic var registrationNumber: String = ""
    @objc dynamic var emptyWeight: Double = 0.0
    @objc dynamic var centerOfGravity: Double = 0.0
    
//    @objc dynamic static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first
//    static let ArchiveUrl = DocumentsDirectory?.appendingPathComponent("aircraft")
    
    
    // MARK: Types
    
    struct PropertyKeys {
        static let name = "name"
        static let photo = "photo"
        static let registrationNumber = "registrationNumber"
        static let emptyWeight = "emptyWeight"
        static let centerOfGravity = "centerOfGarvity"
    }
    
    convenience init? (name: String, photo: Data, registrationNumber: String, centerOfGravity: Double, emptyWeight: Double) {
        self.init()
        
        //The name must not be empty
        guard !name.isEmpty, !registrationNumber.isEmpty else {
            return nil
        }
        //Inialize stored properties
        self.name = name
        self.photo = photo
        self.registrationNumber = registrationNumber
        self.centerOfGravity = centerOfGravity
        self.emptyWeight = emptyWeight
    }
}
    


    
    

    


