//
//  ViewController.swift
//  DogData
//
//  Created by Jeff Li on 1/14/17.
//  Copyright © 2017 Jeff Li. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dogs : Results<Dog>?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }
    
    func updateUI() {
        do {
            let realm = try! Realm()
            self.dogs = realm.objects(Dog.self)
            
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dogs!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let dog = self.dogs![indexPath.row]
        cell.textLabel!.text = "\(dog.name) is \(dog.age) years old"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            let dog = self.dogs![indexPath.row]
            
            do {
                let realm = try! Realm()
                try! realm.write {
                 realm.delete(dog)
                }
            }
            updateUI()
        }
    }
    

}

