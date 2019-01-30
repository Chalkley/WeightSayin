//
//  HomeViewController.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 12/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    let shapeLayer = CAShapeLayer()
    
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var navigationView: GradientView!
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var profileBtn: UIButton!
    @IBOutlet weak var settingsBtn: UIButton!
    @IBOutlet weak var settingsBtnBackground: GradientView!
    
    @IBOutlet weak var settingBtnShadow: UIView!
    @IBOutlet weak var mainBGView: GradientView!
    @IBOutlet weak var newEntryBtn: UIButton!
    @IBOutlet weak var newEntryBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentProgressLbl: UILabel!
    @IBOutlet weak var currentProgressLblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var progressWeightLbl: UILabel!
    @IBOutlet weak var plusOrMinusImage: UIImageView!
    
    @IBOutlet weak var keepGoingLbl: UILabel!
    @IBOutlet weak var keepGoingLblTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var completedGoalImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setProfileName()
    
            let cp = CircularProgressView(frame: CGRect(x: 10.0, y: 10.0, width: 100.0, height: 100.0))
            cp.trackColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6014272186)
            cp.progressColor = UIColor.green
            cp.tag = 101
            self.view.addSubview(cp)
            cp.center = self.view.center
            
            self.perform(#selector(animateProgress), with: nil, afterDelay: 0.2)
        
            if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 1334 {
        }
        
        //Update auto layout ASAP
    
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
            case 1334:
                currentProgressLblHeightConstraint.constant = 15
                keepGoingLblTopConstraint.constant = 30
                newEntryBottomConstraint.constant = 20
                navigationViewHeight.constant = 140
                print("iPhone 6/6S/7/8")
                
            case 1920, 2208:
                currentProgressLblHeightConstraint.constant = 15
                print("iPhone 6+/6S+/7+/8+")
            case 2436:
                print("iPhone X")
            case 2732:
                
                print("iPad 12.9")
            default:
                print("unknown")
            }
        }
        
        if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.nativeBounds.height {
            case 2732:
                
                print("iPad 12.9")
            
            default:
                print("unknown")
            }
        }
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        setProfileName()
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    
    @objc func animateProgress() {
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        
        do {
            let lastWeightEntered = try PersistenceService.context.fetch(fetchRequest)
            for data in lastWeightEntered as [NSManagedObject] {
                print(data.value(forKey: "weight")as! Double)
                let startingWeight = UserDefaults.standard.integer(forKey: "startingWeightKeyName")
                let goalWeight = UserDefaults.standard.integer(forKey: "goalWeightKeyName")
                let progress = Double(data.value(forKey: "weight") as! Double)
        
                let result = Double(progress) - Double(startingWeight)
                
                progressWeightLbl.text = "\(result) lbs"
                
                let startVsDifference = Double(startingWeight) - Double(progress)
                let startVsGoal = Double(startingWeight) - Double(goalWeight)
                let percentage = Double(startVsDifference) / Double(startVsGoal) * 100
                
                let keepGoing = Double(startVsGoal) - Double(startVsDifference)
                
                if Double(startVsGoal) <= Double(startVsDifference) {
                    keepGoingLbl.text = "Well done, you achieved your goal weight!"
                } else {
                keepGoingLbl.text = "You got this, \(keepGoing) lbs to go"
                }
                
                let cP = self.view.viewWithTag(101) as! CircularProgressView
                cP.setProgressWithAnimation(duration: 1.0, value: percentage / 100)
                if Double(startVsGoal) <= Double(startVsDifference) {
                cP.progressColor =  #colorLiteral(red: 0, green: 0.8151872784, blue: 0.1041486147, alpha: 1)
                    completedGoalImage.image = #imageLiteral(resourceName: "bigTick")
                    progressWeightLbl.text = ""
                } else {
                    cP.progressColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                }
                print("\(percentage)%")
                
                if Double(progress) <= Double(startingWeight) {
                    progressWeightLbl.textColor = #colorLiteral(red: 0, green: 0.8151872784, blue: 0.1041486147, alpha: 1)
                } else if Double(progress) >= Double(startingWeight) {
                    progressWeightLbl.textColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
                }

            }
            
        } catch {
            print(error)
        }
    }
    
    func setProfileName() {
        if let name = UserDefaults.standard.string(forKey: "textFieldKeyName") {
            print(name)
            profileName.text = "Keep crushing it \(name)"
        }
    }

    func setupUI() {
        profileName.backgroundColor = .clear
        
        navigationView.layer.cornerRadius = 8
        
        profileBtn.layer.cornerRadius = 10
        profileBtn.clipsToBounds = true
        
        settingsBtn.layer.cornerRadius = settingsBtn.frame.height / 2 
        settingsBtn.clipsToBounds = true
        
        settingsBtnBackground.layer.cornerRadius = settingsBtnBackground.frame.height / 2
        settingsBtnBackground.clipsToBounds = true
        
        settingBtnShadow.layer.cornerRadius = settingBtnShadow.frame.height / 2
        settingBtnShadow.layer.shadowOpacity = 0.5
        settingBtnShadow.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        settingBtnShadow.layer.shadowRadius = 10
        settingBtnShadow.layer.shadowOffset = CGSize(width: 4, height: 6)
        
        mainBGView.layer.cornerRadius = 10
        mainBGView.clipsToBounds = true

        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 6)

        newEntryBtn.layer.cornerRadius = 10
        newEntryBtn.clipsToBounds = true
        
        currentProgressLbl.layer.cornerRadius = 10
        currentProgressLbl.clipsToBounds = true
        
        progressWeightLbl.backgroundColor = .clear
        progressWeightLbl.layer.cornerRadius = 10
        progressWeightLbl.adjustsFontForContentSizeCategory = true
        progressWeightLbl.clipsToBounds = true
        
        keepGoingLbl.backgroundColor = .clear
        
        completedGoalImage.clipsToBounds = true
    }
}


