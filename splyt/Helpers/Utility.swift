//
//  Utility.swift
//
//
//  Created by Deepak Arora on 07/03/16.
//  Copyright © 2016 Deepak Arora . All rights reserved.
//

import UIKit
import SystemConfiguration
import Foundation

var bundle: Bundle = Bundle(){
didSet{
    
    localizeString()
}
}

func localizeString(){
    
    // emailTxtField.placeholder =  NSLocalizedString("khint_email", bundle: bundle, comment: "hello")
}
class Utility: NSObject
{
    
    let lightGreyColor: UIColor = UIColor(red: 197 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    let darkGreyColor: UIColor = UIColor(red: 52 / 255, green: 42 / 255, blue: 61 / 255, alpha: 1.0)
    let overcastBlueColor: UIColor = UIColor(red: 0, green: 187 / 255, blue: 204 / 255, alpha: 1.0)

    
    // MARK:- Alert

    
    class func showAlert(title: String?, message: String?, viewController:UIViewController)
    {
          // bundle = LanguageManager.sharedInstance.getCurrentBundle()
        
        let alertController:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    class func showInternetAlert(viewController:UIViewController)
    {
        let alertController = UIAlertController(title: "Oops!", message: "Please check your internet connection.", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    
    class func showServerErrorAlert(viewController:UIViewController)
    {
        let alertController = UIAlertController(title: nil, message: "Please try again later.", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    // MARK:- Valid emails
    
   
    
    class func commonPingAlert(viewController:UIViewController, title:String, resString:String)
    {
        let actionSheetController: UIAlertController = UIAlertController(title:title, message:resString, preferredStyle: .alert)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel) { action -> Void in
        }
        actionSheetController.addAction(cancelAction)
        //self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        viewController.present(actionSheetController, animated: true, completion: nil)
    }
    
    //MARK: Line spacing For attributed label.
    class  func setTextWithLineSpacing(label:UILabel,text:String,lineSpacing:CGFloat)
    {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        label.attributedText = attrString
    }
    
    
    class func setLableFontlight(sender:UILabel, size:CGFloat){
        
        sender.font = UIFont(name: "ProximaNova-Regular", size: size)
        
    }
    
    class func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }


    
    class func settheme() -> UIColor {
        var selectColor:UIColor = UIColor()
        
        if UserDefaults .standard .object(forKey: "SelectedColorForTheme") != nil {
            
            if UserDefaults .standard .object(forKey: "SelectedColorForTheme") as! String == "blue" {
                selectColor = UIColor(red: (61/255), green: (159/255), blue: (218/255), alpha: 1.0)
            }
            else if UserDefaults .standard .object(forKey: "SelectedColorForTheme") as! String == "red" {
                selectColor = UIColor(red: (234/255), green: (25/255), blue: (33/255), alpha: 1.0)
            }
            else if UserDefaults .standard .object(forKey: "SelectedColorForTheme") as! String == "green" {
                selectColor = UIColor(red: (12/255), green: (19/255), blue: (5/255), alpha: 1.0)
            }
            else if UserDefaults .standard .object(forKey: "SelectedColorForTheme") as! String == "white" {
                selectColor = UIColor.white
            }
            
        }
        return selectColor
    }

    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let ret = (isReachable && !needsConnection)
        
        return ret
        
    }
    
    class func get_label_height(label_pass:UILabel) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x:10, y:0, width:label_pass.frame.size.width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 200
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = label_pass.font
        label.text = label_pass.text
        label.sizeToFit()
        return label.frame.height
    }

    
    public struct RangeValue {
        public var lower: Float = 0.0
        public var upper: Float = 0.0
        
        public init(lower: Float, upper: Float) {
            self.lower = lower
            self.upper = upper
        }
    }
    
    /**
     The struct to encapsulate the information of interval.
     
     Initialization:
     ```
     Interval(min: 50000, max: 100000, stepValue: 10000)
     ```
     */
    
    public struct Interval {
        public private(set) var min: Float = 0.0
        public private(set) var max: Float = 0.0
        public private(set) var stepValue: Float = 0.0
        public private(set) var nodes: [Float] = []
        
        public init(min: Float, max: Float, stepValue: Float) {
            self.min = min
            self.max = max
            self.stepValue = stepValue
            var index = min
            while index <= max {
                self.nodes.append(index)
                index += stepValue
            }
        }
    }

    // MARK:- Calculate time for question and answer
    class func getTime(time: String) -> String {
        var questDateStrForShow = NSString()
        var questDateStr = NSString()
        questDateStr = time as NSString
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let questDate = formatter.date(from: questDateStr as String)
        let todaysDate:NSDate = NSDate()
        let interval = todaysDate.timeIntervalSince(questDate!)
        let ti = NSInteger(interval)
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        let days   = (ti / 86400)
        if days > 10
        {
            formatter.dateFormat = "yyyy-MM-dd"
            let questTimeStr: String = formatter.string(from: questDate!)
            questDateStrForShow = (questTimeStr) as NSString!
        }
        else if days > 0 && days <= 10
        {
            questDateStrForShow = "\(days) days ago" as NSString
        }
        else if hours > 0  && hours < 24
        {
            questDateStrForShow = "\(hours) hours ago" as NSString
        }
        else if minutes > 0 && minutes < 60
        {
            questDateStrForShow =  "\(minutes) mins" as NSString
        }
        else if minutes <= 1
        {
            questDateStrForShow = "Just now"
        }
        return questDateStrForShow as String
    }

    class func getHtmlFormat(fromString htmlString: String) -> NSAttributedString? {
        guard let htmlData = htmlString.data(using: String.Encoding.unicode) else
        {
            print("Could not get htmlData")
            return nil
        }
        do {
            return try NSAttributedString(data: htmlData, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        } catch let error {
            print(error)
            return nil
        }
    }

    class func fillColor(statusString: String) -> UIColor {
        
        var textColor:UIColor = UIColor()

        if statusString == "Payment Pending" ||  statusString == "Pending"{
            textColor = UIColor(red: 255.0/255, green: 180.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
        else if statusString == "Approved" {
            textColor = UIColor(red: 1.0/255, green: 185.0/255.0, blue: 209.0/255.0, alpha: 1.0)
        }
        else if statusString == "Payment Confirmed" {
            textColor = UIColor(red: 123.0/255, green: 202.0/255.0, blue: 71.0/255.0, alpha: 1.0)
        }
        else if statusString == "Delivered" {
            textColor = UIColor(red: 0.0/255, green: 211.0/255.0, blue: 169.0/255.0, alpha: 1.0)
        }
        else if statusString == "Cancelled" {
            textColor = UIColor(red: 255.0/255, green: 12.0/255.0, blue: 50.0/255.0, alpha: 1.0)
        }
        else if statusString == "Completed" {
            textColor = UIColor(red: 0.0/255, green: 176.0/255.0, blue: 49.0/255.0, alpha: 1.0)
        }
        else if statusString == "Shipped" {
            textColor = UIColor(red: 0.0/255, green: 150.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        else if statusString == "Paid" {
            textColor = UIColor(red: 255.0/255, green: 180.0/255.0, blue: 28.0/255.0, alpha: 1.0)
        }
        else if statusString == "Refunded" {
            textColor = UIColor(red: 155.0/255, green: 0.0/255.0, blue: 24.0/255.0, alpha: 1.0)
        }
        else if statusString == "In Process" {
            textColor = UIColor(red: 102.0/255, green: 172.0/255.0, blue: 165.0/255.0, alpha: 1.0)
        }
        else if statusString == "Return Requested" {
            textColor = UIColor(red: 0.0/255, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        else if statusString == "Cash on Delivery" {
            textColor = UIColor(red: 171.0/255, green: 0.0/255.0, blue: 196.0/255.0, alpha: 1.0)
        }
        else if statusString == "Refunded/Completed" {
            textColor =  UIColor(red: 155.0/255, green: 0.0/255.0, blue: 24.0/255.0, alpha: 1.0)
        }
        else{
            textColor = UIColor(red: 0.0/255, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0)
        }
        return textColor
    }
    
    class func setBackgroundColor(statusString: String) -> UIColor {
        
        var textColor:UIColor = UIColor()
        
        if statusString == "Payment Pending" ||  statusString == "Pending" {
            textColor = UIColor(red: 255.0/255, green: 246.0/255.0, blue: 224.0/255.0, alpha: 1.0)
        }
        else if statusString == "Approved" {
            textColor = UIColor(red: 220.0/255, green: 250.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        }
        else if statusString == "Payment Confirmed" {
            textColor = UIColor(red: 228.0/255, green: 255.0/255.0, blue: 210.0/255.0, alpha: 1.0)
        }
        else if statusString == "Delivered" {
            textColor = UIColor(red: 219.0/255, green: 250.0/255.0, blue: 244.0/255.0, alpha: 1.0)
        }
        else if statusString == "Cancelled" {
            textColor = UIColor(red: 255.0/255, green: 227.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        }
        else if statusString == "Completed" {
            textColor = UIColor(red: 219.0/255, green: 245.0/255.0, blue: 226.0/255.0, alpha: 1.0)
        }
        else if statusString == "Shipped" {
            textColor = UIColor(red: 225.0/255, green: 243.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        else if statusString == "Paid" {
            textColor = UIColor(red: 255.0/255, green: 240.0/255.0, blue: 245.0/255.0, alpha: 1.0)
        }
        else if statusString == "Refunded" {
            textColor = UIColor(red: 255.0/255, green: 227.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        }
        else if statusString == "In Process" {
            textColor = UIColor(red: 229.0/255, green: 243.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        else if statusString == "Return Requested" {
            textColor = UIColor(red: 255.0/255, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        else if statusString == "Cash on Delivery" {
            textColor = UIColor(red: 251.0/255, green: 221.0/255.0, blue: 255.0/255.0, alpha: 1.0)
        }
        else if statusString == "Refunded/Completed" {
            textColor =  UIColor(red: 255.0/255, green: 227.0/255.0, blue: 231.0/255.0, alpha: 1.0)
        }
        else{
            textColor = UIColor(red: 75.0/255, green: 75.0/255.0, blue: 75.0/255.0, alpha: 0.3)
        }
        return textColor
    }
    
}
