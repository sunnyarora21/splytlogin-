//
//  LoginViewController.swift
//  splyt
//
//  Created by Anil Kapoor on 10/24/17.
//  Copyright © 2017 Anil Kapoor. All rights reserved.
//

import UIKit
//import Alamofire
//import SwiftyJSON
import MBProgressHUD
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth
import FirebaseFacebookAuthUI
class LoginViewController: UIViewController {
    
    //Mark:- Outlets
    @IBOutlet weak var viewForUserName: UIView!
    @IBOutlet weak var viewForPassword: UIView!
    
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    @IBOutlet weak var viewForFacebookBtn: UIView!
    
    
    //MARK:- Variables
  //  let loginButton = FBSDKLoginButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //loginButton.delegate = self as! FBSDKLoginButtonDelegate

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ...
    }
    @IBAction func loginWithFacebookBtnClicked(_ sender: UIButton) {
        //"fields": "id, name, first_name, last_name, picture.type(large), email"
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = FBSDKAccessToken.current() else {
                print("Failed to get access token")
                return
            }
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                
                // Present the main view
                let successView = self.storyboard!.instantiateViewController(withIdentifier: "SuccesFullRegistrationViewIdentifier") as! SuccesFullRegistrationViewController
                self.navigationController!.pushViewController(successView, animated: true)
                })
                
           // })
            
        }   
    }
      //  let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
//        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) -> Void in
//            if (error == nil){
//                let fbloginresult : FBSDKLoginManagerLoginResult = result!
//                // if user cancel the login
//                if (result?.isCancelled)!{
//                    return
//                }
//                if(fbloginresult.grantedPermissions.contains("email"))
//                {
//                    self.getFBUserData()
//                }
//            }
//        }
   // }
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    //everything works print the user data
                    print(result!)
                }
            })
        }
    }
    
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
        if userNameTxtField.text == "" || userNameTxtField.text == " " {
            Utility.showAlert(title: "Alert", message: "Please enter user name.", viewController: self)
        }
        else if passwordTxtField.text == "" || passwordTxtField.text == " "{
          Utility.showAlert(title: "Alert", message: "Please enter Passwprd.", viewController: self)
        }
        else{
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
            let parameters : NSDictionary  =
                ["username": userNameTxtField.text!,
                 "password" : passwordTxtField.text!,
                 "device_type" : "I",
                 "device_token" : "yuysduayasudyuas",
            ]
            print(parameters)
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
           
                    FIRAuth.auth()?.signIn(withEmail: self.userNameTxtField.text!, password: self.passwordTxtField.text!) { (user, error) in
                        
                        if error == nil {

                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    //                let vc = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                    //     self.present(vc!, animated: true, completion: nil)
                    //  SuccesFullRegistrationViewIdentifier
                    let successView = self.storyboard!.instantiateViewController(withIdentifier: "SuccesFullRegistrationViewIdentifier") as! SuccesFullRegistrationViewController
                    self.navigationController!.pushViewController(successView, animated: true)
                    
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }

//            Alamofire.request("\(GlobalConstants.baseURL)/login", method: .post, parameters: parameters as? Parameters, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (response:DataResponse<Any>) in
//                
//                switch(response.result) {
//                    
//                case .success(_):
//                    
//                    if response.result.value != nil{
//                        
//                        var dict:NSDictionary = NSDictionary()
//                        dict = (response.result.value! as? NSDictionary)!
//                        
//                        print(dict)
//                        
//                        if dict.value(forKey: "error")as! Bool == false{
//                            
//                            var userInfoDict:NSDictionary = NSDictionary()
//                            userInfoDict = dict.value(forKey: "userInfo") as! NSDictionary
//                            
//                            if userInfoDict.value(forKey: "status") as! Bool == true{
//                                //  SuccesFullRegistrationViewIdentifier
//                                let successView = self.storyboard!.instantiateViewController(withIdentifier: "SuccesFullRegistrationViewIdentifier") as! SuccesFullRegistrationViewController
//                                self.navigationController!.pushViewController(successView, animated: true)
//                                
//                            }
//                            
//                        }
//
//                        
//                    }
//                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//                    break
//                    
//                case .failure(_):
//                    MBProgressHUD.hideAllHUDs(for: self.view, animated: true)
//                    
//                    Utility.showAlert(title: "Alert", message: "Something went wrong. Please try again later.", viewController: self)
//                    break
//                    
//                }
//            }
        //}
        
        
   // }
    
    @IBAction func forgotPasswordBtnClicked(_ sender: UIButton) {
        
        let forgotPasswordView = self.storyboard!.instantiateViewController(withIdentifier: "ForgetPasswordViewIdentifier") as! ForgetPasswordViewController
        self.navigationController!.pushViewController(forgotPasswordView, animated: true)
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        let signView = self.storyboard!.instantiateViewController(withIdentifier: "SignUpViewIdentifier") as! SignUpViewController
        self.navigationController!.pushViewController(signView, animated: true)

    }
    
    @IBAction func helpBtnClicked(_ sender: UIButton) {
    }
    
    
}
