//
//  ProfileViewController.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 12/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit
import CoreData


class ProfileViewController: UIViewController, UITextFieldDelegate {
    
    //User Defaults
    
    let nameTextFieldKeyConstant = "textFieldKeyName"
    let startingWeightTextFieldConstant = "startingWeightKeyName"
    let goalWeightTextFieldConstant = "goalWeightKeyName"
    
    //Outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var startingWeightLbl: UILabel!
    @IBOutlet weak var goalWeightLbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var weightTextfield: UITextField!
    @IBOutlet weak var goalTextfield: UITextField!
    @IBOutlet weak var mainBGView: GradientView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var navigationView: GradientView!
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var quoteTextfield: UITextView!
    
    @IBOutlet weak var mainBGConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setUserDetails()
        nameTextfield.delegate = self
        weightTextfield.delegate = self
        goalTextfield.delegate = self
        
        //Update auto layout ASAP
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                quoteTextfield.isHidden = true
                mainBGConstraint.constant = 30
                navigationViewHeight.constant = 140
                print("iPhone 6/6S/7/8")
                
            case 1920, 2208:
                quoteTextfield.isHidden = true
                mainBGConstraint.constant = 30
                
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
            default:
                print("unknown")
            }
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == nameTextfield {
            weightTextfield.becomeFirstResponder()
        } else if textField == weightTextfield {
            goalTextfield.becomeFirstResponder()
        } else if textField == goalTextfield {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setUserDetails() {
        
        let defaults = UserDefaults.standard
       
        if let nameTextFieldValue = defaults.string(forKey: nameTextFieldKeyConstant) {
            nameTextfield.text = nameTextFieldValue
        }
        
        let weight = defaults.integer(forKey: startingWeightTextFieldConstant)
        weightTextfield.text = "\(weight)"
        
        let goalWeight = defaults.integer(forKey: goalWeightTextFieldConstant)
        goalTextfield.text = "\(goalWeight)"
        

    }
    
    @IBAction func saveBtnTapped(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.setValue(nameTextfield.text, forKey: nameTextFieldKeyConstant)
        defaults.setValue(weightTextfield.text, forKey: startingWeightTextFieldConstant)
        defaults.setValue(goalTextfield.text, forKey: goalWeightTextFieldConstant)
        print("Profile details saved")
    }
    
    func setUpUI() {
        navigationView.layer.cornerRadius = 8
        saveBtn.layer.cornerRadius = 10
        saveBtn.clipsToBounds = true
        saveBtn.tintColor = #colorLiteral(red: 0.9607843137, green: 0.5215686275, blue: 0.1607843137, alpha: 1)
        saveBtn.setTitle("Save Profile", for: .normal)
        saveBtn.backgroundColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 0.4)
        
        nameTextfield.clearsOnInsertion = true
        weightTextfield.keyboardType = .decimalPad
        
        weightTextfield.clearsOnInsertion = true
        goalTextfield.keyboardType = .decimalPad
    
        goalTextfield.clearsOnInsertion = true
        mainBGView.layer.cornerRadius = 10
        mainBGView.clipsToBounds = true
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 6)
        
    }
    
    

    
    @IBAction func editProfileTapped(_ sender: Any) {
        userProfileAlert()
    }
    
        func userProfileAlert() {
        //Create controller
        let alertCT = UIAlertController(title: "Profile", message: "Enter details below", preferredStyle: .alert)

        //Add textFields
    
        alertCT.addTextField { (textFieldName) in
            textFieldName.placeholder = "Name"
        alertCT.addTextField { (textFieldWeight) in
            textFieldWeight.placeholder = "Starting weight (lbs)"
            textFieldWeight.keyboardType = .decimalPad
        alertCT.addTextField { (textFieldGoal) in
            textFieldGoal.placeholder = "Goal weight (lbs)"
            textFieldGoal.keyboardType = .decimalPad
        }
        
            //Creat Alert Action
            
            let action = UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default) { (alert: UIAlertAction!) -> Void in
            
            let name = alertCT.textFields![0] 
            self.nameTextfield.text = name.text
            let weight = alertCT.textFields![1]
            self.weightTextfield.text = weight.text
            let goal = alertCT.textFields![2]
            self.goalTextfield.text = goal.text
        
            alertCT.dismiss(animated: true, completion: nil)
            }

            //Add alert to controller

            alertCT.addAction(action)

            self.present(alertCT, animated: true, completion: nil)
            }
        }
    }
    
    func emptyProfile() {
        if nameTextfield.text == "" {
            userProfileAlert()
        } else {
            return
        }
    }
}

    

