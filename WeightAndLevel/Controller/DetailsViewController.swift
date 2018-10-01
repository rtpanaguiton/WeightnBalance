//
//  DetailsViewController.swift
//  WeightAndLevel
//
//  Created by Reymund on 18/08/2018.
//  Copyright © 2018 ReymundoPanaguiton. All rights reserved.
//

import UIKit
import os.log

class DetailsViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var emptyWeightLabel: UITextView!
    @IBOutlet weak var aircraftMomentArm: UITextView!
    @IBOutlet weak var aircraftImageView: UIImageView!
    @IBOutlet weak var enterNameTextField: UITextField!
    @IBOutlet weak var registrationNumberTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    /* This property is either passed by DetailViewController in prepare(for : ) or constructed as part of adding a aircraft */
    
    var aircraft: Aircraft?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        //Set up views if editing an existing Aircraft
        
        if let aircraft = aircraft {
            navigationItem.title = aircraft.name
            enterNameTextField.text = ""
            let imageData = aircraft.photo
            aircraftImageView.image = UIImage(data: imageData!)
            registrationNumberTextField.text = aircraft.registrationNumber
            emptyWeightLabel.text = String(aircraft.emptyWeight)
            aircraftMomentArm.text = String(aircraft.centerOfGravity)
        }
        
        enterNameTextField.delegate = self
        emptyWeightLabel.delegate = self
        aircraftMomentArm.delegate = self
        registrationNumberTextField.delegate = self
        
    }
 
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
    }

    //Navigation:
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        
        let isPresentingInAddAircraftMode = presentingViewController is UINavigationController
        
        if isPresentingInAddAircraftMode {
            
            dismiss(animated: true, completion: nil)
            
        } else if let owningNavigationController =  navigationController {
            
            owningNavigationController.popViewController(animated: true)
            
        } else {
            
            fatalError("The DetailViewController is not inside a navigation controller")
        }
    }
    
    //This method lets you configure a view controller before it is presented.
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            fatalError("The save button was not pressed, Cancelling")}
        
        let name = navigationItem.title ?? ""
        let image = aircraftImageView.image
        let imageData = UIImagePNGRepresentation(image!)!
        let photo = imageData
        let registrationNumber = self.registrationNumberTextField.text!
        let centerOfGravity = Double(aircraftMomentArm.text!)!
        let emptyWeight = Double(emptyWeightLabel.text!)!
        
            // Set the aircraft to be passed to the DetailViewController after the unwind segue
            
        aircraft = Aircraft(name: name, photo: photo, registrationNumber: registrationNumber, centerOfGravity: centerOfGravity, emptyWeight: emptyWeight)!
        
            return
    }
    
    
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard.
        enterNameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard  let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary providing image but was provided \(info)")}
        aircraftImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        navigationItem.title = textField.text
        textField.resignFirstResponder()
        textField.text = ""
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


