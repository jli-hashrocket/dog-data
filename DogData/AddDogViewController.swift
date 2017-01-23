//
//  AddDogViewController.swift
//  DogData
//
//  Created by Jeff Li on 1/14/17.
//  Copyright © 2017 Jeff Li. All rights reserved.
//

import UIKit
import RealmSwift

class AddDogViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var nameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.picker.dataSource = self
        self.picker.delegate = self
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 101
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }

    @IBAction func saveTapped(_ sender: Any) {
        let dogAge = self.picker.selectedRow(inComponent: 0)
        let dogName = self.nameText.text
        
        let dog = Dog()
        dog.name = dogName!
        dog.age = dogAge
        
        do {
            let realm = try! Realm()
            try! realm.write {
                realm.add(dog)
            }
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
