//
//  ViewController.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 11/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit
import CoreData



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    

    @IBOutlet weak var navigationView: GradientView!
    @IBOutlet weak var mainBGView: GradientView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    
    var entry = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchRequest()
        setupUI()
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                navigationViewHeight.constant = 140
                print("iPhone 6/6S/7/8")
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
            default:
                print("unknown")
            }
        }
    }
    
    func setupUI() {
        navigationView.layer.cornerRadius = 8
        
        mainBGView.layer.cornerRadius = 10
        mainBGView.clipsToBounds = true
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 5)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    //MARK: Get what you saved
    
    func fetchRequest() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
            do {
                let entry = try PersistenceService.context.fetch(fetchRequest)
                self.entry = entry
                self.tableView.reloadData()
            } catch {
                print(error)
        }
    }
    
    @IBAction func addTapped(_ sender: Any) {
        let alert = UIAlertController(title: "New Entry", message: nil, preferredStyle: .alert)
            alert.addTextField { (textField) in
            textField.placeholder = "Date"
                textField.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
            alert.addTextField { (textField) in
                textField.placeholder = "Weight (lbs)"
                textField.keyboardType = .decimalPad
                textField.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
                
            }
            
            let action = UIAlertAction(title: "Post", style: .default) { (_) in
                
                if (alert.textFields?.first?.text)! == "" || alert.textFields?.last?.text == "" {
                    print("Empty fields")
                } else {
                
                let date = alert.textFields?.first?.text
                let weight = alert.textFields?.last?.text
                
            //MARK: Save (need to change to catch erros)
                let entry = Entry(context: PersistenceService.context)
                entry.date = date
                entry.weight = Double(weight!)!
                PersistenceService.saveContext()
                self.entry.append(entry)
                self.tableView.reloadData()
                }
            }
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(action)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entry.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DATE_WEIGHT_CELL, for: indexPath) as! DateWeightTableViewCell
        
        cell.dateLabel.text = entry[indexPath.row].date
        cell.weightLabel.text = String(entry[indexPath.row].weight)
        return cell 
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            PersistenceService.context.delete(self.entry[indexPath.row])
            
            do {
                try PersistenceService.context.save()
                self.entry.removeAll()
                self.fetchRequest()
                self.tableView.reloadData()
            } catch let Err {
                print(Err.localizedDescription)
                //create alert to go here incase entry doesnt delete.
                self.deleteRowFailed()
            }
        }
    }
    
    //Alerts
    
    func deleteRowFailed() {
        let alert = UIAlertController(title: "Delete Failed", message: "Please try again.", preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}


