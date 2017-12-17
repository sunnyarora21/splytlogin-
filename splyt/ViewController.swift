//
//  ViewController.swift
//  splyt
//
//  Created by Anil Kapoor on 9/22/17.
//  Copyright © 2017 Anil Kapoor. All rights reserved.
//

import UIKit
import SinchVerification
import Alamofire
import SwiftyJSON
import MBProgressHUD

class ViewController: UIViewController {
 
    
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBOutlet weak var verifyButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var viewforPhoneno: UIView!
    @IBOutlet weak var viewForNextBtn: UIView!
    
    // var verification : Verification!
   // var applicationkey = "89789369-0d4a-4bb0-8f42-31e349aa9f6a";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loadivarthe view, typically from a nib.
        
        viewForNextBtn.layer.cornerRadius = 5
        viewForNextBtn.clipsToBounds = true
        viewforPhoneno.layer.cornerRadius = 5
        viewforPhoneno.clipsToBounds = true
         }

    func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        numberTextField.resignFirstResponder()
    }
   
    @IBAction func verifyPhoneNumber(_ sender: UIButton) {
        
        numberTextField.resignFirstResponder()
        
        
        
        if numberTextField.text == "" || numberTextField.text == " "{
            Utility.showAlert(title: "Alert", message: "Please Provide Phone number", viewController: self)
        }
        else{
        print(numberTextField.text!)
            MBProgressHUD.showAdded(to: self.view, animated: true)
//        verification = SMSVerification("c1dd042c-c60b-4836-97f7-07730e5ca08c", phoneNumber: numberTextField.text!)
//
//        verification.initiate { (initiationResult, error) in
//            if initiationResult.success == true {
//
//                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//                //Process the flow and display UI for verification of code
//                let otpView = self.storyboard!.instantiateViewController(withIdentifier: "PhoneNoVerificationViewIdentifier") as! PhoneNoVerificationViewController
//                otpView.PhoneNoStr = self.numberTextField.text!
//                self.navigationController!.pushViewController(otpView, animated: true)
//
//            }
//            else {
//                print(error!)
//                MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//                Utility.showAlert(title: "Alert", message: "Something went wrong. Please try again", viewController: self)
//            }
        // }
       }

    }

    @IBAction func loginBtnClicked(_ sender: UIButton) {
        //LoginViewIdentifier
        let loginView = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewIdentifier") as! LoginViewController
        self.navigationController!.pushViewController(loginView, animated: true)

    }
    
    @IBAction func helpBtnClicked(_ sender: UIButton) {
    }
    
    @IBAction func showKeyBoardBtnClicked(_ sender: UIButton) {
        numberTextField.becomeFirstResponder()
    }
   
}

