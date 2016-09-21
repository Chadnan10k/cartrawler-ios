//
//  ViewController.swift
//  CartrawlerTestSwift
//
//  Created by Lee Maguire on 16/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let sdk = CartrawlerSDK(requestorID: "68622", languageCode: "EN", isDebug: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let bookingSummary = storyboard?.instantiateViewController(withIdentifier: "BookingSummaryViewController") as! BookingSummaryViewController
//        sdk.overridePaymentSummaryViewController(bookingSummary)
        
        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
        CartrawlerSDK.appearance().buttonColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().buttonShadowEnabled = true
        CartrawlerSDK.appearance().buttonCornerRadius = 30
        CartrawlerSDK.appearance().buttonTextColor = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
        
        CartrawlerSDK.appearance().viewBackgroundColor = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().locationSelectionBarColor = UIColor.init(red: 27.0/255, green: 78.0/255.0, blue: 148.0/255.0, alpha: 1)
        
        CartrawlerSDK.appearance().calendarHeaderTopSectionColor = UIColor.init(red: 0.0/255, green: 55.0/255.0, blue: 145.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarHeaderBottomSectionColor = UIColor.init(red: 18.0/255, green: 147.0/255.0, blue: 233.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarStartCellColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarMidCellColor = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().calendarEndCellColor = UIColor.init(red: 241.0/255, green: 201.0/255.0, blue: 51.0/255.0, alpha: 1)
        
        CartrawlerSDK.appearance().textFieldTint = UIColor.init(red: 26.0/255, green: 38.0/255.0, blue: 88.0/255.0, alpha: 1)
        CartrawlerSDK.appearance().fontName = "AppleSDGothicNeo-Regular"
        CartrawlerSDK.appearance().boldFontName = "AppleSDGothicNeo-Bold"

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func carRental(_ sender: AnyObject) {
        sdk.presentCarRental(in: self)
    }
    
    @IBAction func groundTransport(_ sender: AnyObject) {
        sdk.presentGroundTransport(in: self)
    }
    
    @IBAction func airportSearch(_ sender: AnyObject) {
        sdk.presentCarRental(withFlightDetails: "DUB",
                             firstName: "Lee",
                             surname: "Maguire",
                             additionalPassengers: 1,
                             email: "lmaguire@cartrawler.com",
                             phone: "0866666666",
                             flightNo: "FR444",
                             addressLine1: "123 Cartrawler St",
                             addressLine2: "",
                             city: "Dublin",
                             postcode: "5",
                             countryCode: "IE",
                             countryName: "Ireland",
                             completion: "")
    }

}

