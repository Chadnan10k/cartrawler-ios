//
//  ViewController.swift
//  CartrawlerTestSwift
//
//  Created by Lee Maguire on 16/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let sdk = CartrawlerSDK(requestorID: "68622", languageCode: "EN", sandboxMode: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        UIApplication.shared.setStatusBarStyle(.lightContent, animated: false)
        
//        CartrawlerSDK.appearance().boldFontName = "HelveticaNeue-Medium"
//        CartrawlerSDK.appearance().fontName = "HelveticaNeue-Light"
        
        CartrawlerSDK.appearance().presentAnimated = true
        CartrawlerSDK.appearance().modalTransitionStyle = .coverVertical
        CartrawlerSDK.appearance().modalPresentationStyle = .overFullScreen

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
        
        let strTime = "2016-09-27 10:00:00"
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let pickupDate = formatter.date(from: strTime)!
        let dropoffDate = pickupDate.addingTimeInterval(60 * 60 * 24)
        
        sdk.presentCarRental(withFlightDetails: "DUB",
                             pickupDate: pickupDate,
                             return: dropoffDate,
                             firstName: "Lee",
                             surname: "Maguire",
                             driverAge: 30,
                             additionalPassengers: 2,
                             email: "lmaguire@cartrawler.com",
                             phone: "0866666666",
                             flightNo: "FR444",
                             addressLine1: "123 Cartrawler St",
                             addressLine2: "",
                             city: "Dublin",
                             postcode: "5",
                             countryCode: "IE",
                             countryName: "Ireland",
                             overViewController: self)
        { (success, errorMessage) in
            
        }
    }

}

