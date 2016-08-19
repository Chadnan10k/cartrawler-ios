//
//  ViewController.swift
//  CartrawlerSDK-TestApp
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

import UIKit

//class ViewController: UIViewController {
//    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
//
//        CartrawlerSDK.appearance().buttonColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().buttonTextColor = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().viewBackgroundColor = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().locationSelectionBarColor = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().navigationBarTint = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().calendarHeaderTopSectionColor = UIColor.init(red: 0.0/255, green: 55.0/255.0, blue: 145.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().calendarHeaderBottomSectionColor = UIColor.init(red: 18.0/255, green: 147.0/255.0, blue: 233.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().calendarStartCellColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().calendarMidCellColor = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().calendarEndCellColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
//        CartrawlerSDK.appearance().textFieldTint = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
//
//        
////        let customStepOne = storyboard?.instantiateViewControllerWithIdentifier("CustomStepOneViewController") as! CustomStepOneViewController
////        api.overrideStepOneViewController(customStepOne)
//        
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func openCartrawler(sender: AnyObject) {
//        let cartrawlerAPI = CartrawlerSDK(requestorID: "592248", languageCode: "EN", isDebug: true)
//        cartrawlerAPI.presentCarRentalInViewController(self)
//        //cartrawlerAPI!.presentGroundTransport(in: self)
//    }
//
//}
//
class ViewController: UIViewController {
    
    let cartrawlerSDK = CartrawlerSDK(requestorID: "643826", languageCode: "EN", isDebug: true)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if #available(iOS 8.0, *) {
            
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            // Fallback on earlier versions
        }
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        CartrawlerSDK.appearance().buttonColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().buttonTextColor = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().viewBackgroundColor = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().locationSelectionBarColor = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().navigationBarTint = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarHeaderTopSectionColor = UIColor.init(red: 0.0/255, green: 55.0/255.0, blue: 145.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarHeaderBottomSectionColor = UIColor.init(red: 18.0/255, green: 147.0/255.0, blue: 233.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarStartCellColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarMidCellColor = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarEndCellColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().textFieldTint = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
        
//        CartrawlerSDK.appearance().fontName = "Chalkduster"
//        CartrawlerSDK.appearance().boldFontName = "ChalkboardSE-Bold"

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openCartrawler(sender: AnyObject) {
        //643826 RYR
        //592248
        cartrawlerSDK.presentCarRental(in: self)
       // cartrawlerAPI!.presentGroundTransport(in: self)
    }
    
}

