//
//  AboutViewController.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 26/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    @IBOutlet weak var navigationView: GradientView!
    
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainGBView: GradientView!
    
    @IBOutlet weak var shadowBGView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
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

    func setUpUI() {
        navigationView.layer.cornerRadius = 8
        
        mainGBView.clipsToBounds = true
        mainGBView.layer.cornerRadius =  10
        
        shadowBGView.layer.cornerRadius = 10
        shadowBGView.layer.shadowOpacity = 0.5
        shadowBGView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowBGView.layer.shadowRadius = 10
        shadowBGView.layer.shadowOffset = CGSize(width: 4, height: 6)
    }

}
