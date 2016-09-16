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
        let bookingSummary = storyboard?.instantiateViewController(withIdentifier: "BookingSummaryViewController") as! BookingSummaryViewController
        sdk.overridePaymentSummaryViewController(bookingSummary)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func carRental(_ sender: AnyObject) {
        sdk.presentCarRental(in: self)
    }

}

