//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Alexis Kirkman on 3/20/17.
//  Copyright © 2017 Alexis Kirkman. All rights reserved.
//

import UIKit
class DetailViewController: UIViewController, UITextFieldDelegate {

   @IBOutlet var nameField: customTextField!
   @IBOutlet var serialNumberField: customTextField!
   @IBOutlet var valueField: customTextField!
   @IBOutlet var dateLabel: UILabel!
   @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
      view.endEditing(true)
   }
   
   var item: Item!{
      didSet {
         navigationItem.title = item.name
      }
   }
   
   let numberFormatter: NumberFormatter = {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      formatter.minimumFractionDigits = 2
      formatter.maximumFractionDigits = 2
      return formatter }()
   
   let dateFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateStyle = .medium
      formatter.timeStyle = .none
      return formatter }()

   override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      nameField.text = item.name
      serialNumberField.text = item.serialNumber
      valueField.text =
         numberFormatter.string( from: NSNumber(value: item.valueInDollars))
      dateLabel.text = dateFormatter.string(from: item.dateCreated)
      
   }
   
   override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      
      // Clear first responder 
      view.endEditing(true)
      

      // "Save" changes to item 
      item.name = nameField.text ?? ""
      item.serialNumber = serialNumberField.text
      if let valueText = valueField.text,
         let value = numberFormatter.number(from: valueText) {
         item.valueInDollars = value.intValue
      } else {
         item.valueInDollars = 0
      }
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
   }
   
   override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
      // If the triggered segue is the "showItem" segue
      switch segue.identifier {
      case "changeDate"?:
            let dateViewController = segue.destination as! DateViewController
            dateViewController.item = item
         
      default:
         preconditionFailure("Unexpected segue identifier.")
      }
   }

  
   
}


