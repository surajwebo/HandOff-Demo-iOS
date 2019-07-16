//
//  ViewController.swift
//  HandsoffApp
//
//  Created by Suraj on 15/07/19.
//  Copyright © 2019 MangoApps. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldEmailId: UITextField!
    @IBOutlet weak var txtFieldPhoneNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let activity = NSUserActivity(activityType: "com.mangoapps.handsoff-demoapp")
        activity.title = "HandoffDemoApp"
        activity.userInfo = ["FirstName": "", "LastName" : "", "EmailId": "", "PhoneNumber": ""]
        userActivity = activity
        userActivity?.becomeCurrent()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.updateUserActivityState(userActivity!)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.txtFieldFirstName:
            self.txtFieldLastName.becomeFirstResponder()
        case self.txtFieldLastName:
            self.txtFieldEmailId.becomeFirstResponder()
        case self.txtFieldEmailId:
            self.txtFieldPhoneNumber.becomeFirstResponder()
        default:
            return true
        }
        return true
    }

    override func updateUserActivityState(_ activity: NSUserActivity) {
        activity.addUserInfoEntries(from: ["FirstName": self.txtFieldFirstName.text!, "LastName" : self.txtFieldLastName.text!, "EmailId": self.txtFieldEmailId.text!, "PhoneNumber": self.txtFieldPhoneNumber.text!])
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        self.txtFieldFirstName.text         = activity.userInfo!["FirstName"] as? String
        self.txtFieldLastName.text          = activity.userInfo!["LastName"] as? String
        self.txtFieldEmailId.text           = activity.userInfo!["EmailId"] as? String
        self.txtFieldPhoneNumber.text       = activity.userInfo!["PhoneNumber"] as? String
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}

