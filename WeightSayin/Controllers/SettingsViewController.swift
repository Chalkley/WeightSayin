//
//  SettingsViewController.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 19/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit
import MessageUI
import StoreKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bgGradientView: GradientView!
    
    @IBOutlet weak var navigationViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var navigationView: GradientView!
    var settings = [Settings]()
    var social = [SocialMedia]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.dataSource = self
        tableView.delegate = self
    
        settings = DataService.instance.getSettings()
        social = DataService.instance.getSocial()
        
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
        bgGradientView.layer.cornerRadius = 10
        bgGradientView.clipsToBounds = true
        
        shadowView.layer.cornerRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOffset = CGSize(width: 4, height: 6)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SETTINGS_CELL, for: indexPath) as! SettingsTableViewCell
        let settingCell = settings[indexPath.row]
        cell.updateViews(settings: settingCell)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: SETTINGS_TO_ABOUT, sender: self)

        case 1:
            let mailComposeViewController = configureMailController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposeViewController, animated: true, completion: nil)
            } else {
                showMailError()
            }
        case 2:
            if #available( iOS 10.3,*) {
                SKStoreReviewController.requestReview()
            }
        case 3:
            let activityVC = UIActivityViewController(activityItems: ["https://itunes.apple.com/us/app/weightgoals/id1400990542?ls=1&mt=8"], applicationActivities: nil)
            activityVC.popoverPresentationController?.sourceView = self.view
            
            self.present(activityVC, animated: true, completion: nil)
            
        case 4:
            self.openInBrowser(url: URL(string: "https://www.jasonchalkley.com")!)
            
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return social.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SETTINGS_COLLECTION_CELL, for: indexPath) as! SettingsCollectionViewCell
        let socialCell = social[indexPath.row]
        cell.updateViews(socialMedia: socialCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.openInBrowser(url: URL(string: "https://www.instagram.com/chalkl3y/")!)
        case 1:
            self.openInBrowser(url: URL(string: "https://itunes.apple.com/us/app/weightgoals/id1400990542?ls=1&mt=8")!)
        case 2:
            self.openInBrowser(url: URL(string: "https://www.linkedin.com/in/jason-chalkley-a7941a161/")!)
        case 3:
            self.openInBrowser(url: URL(string: "https://www.jasonchalkley.com")!)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width / 4) - 13, height: 40)
    }
    
    
    
    //Open in browser
    
    func openInBrowser(url:URL) {
        print("open in preferred browser")
        
        var browser = "safari"
        if browser == "opera" {
            browser = "firefox://open-url?url=http://"
        } else if browser == "chrome" {
            browser = "googleChrome://"
        } else if browser == "safari" {
            browser = "safari://"
        }
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: ["" : ""], completionHandler: nil)
        }
    }
    
    
    
    //Mail
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["jasonmchalkley@gmail.com"])
        mailComposerVC.setSubject("Weight Goals feedback")
        
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

}


