//
//  Gradaient effect.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 11/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit

@IBDesignable

class GradientView: UIView {
    
    @IBInspectable var oneColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable var twoColor: UIColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1) {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()   //CA stands for core animation
        gradientLayer.colors = [oneColor.cgColor, twoColor.cgColor]
        gradientLayer.opacity = 0.5
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
