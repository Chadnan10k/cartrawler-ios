//
//  CustomStepOneViewController.swift
//  CartrawlerSDK-TestApp
//
//  Created by Lee Maguire on 17/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

import UIKit

class CustomStepOneViewController: CTViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        viewType = ViewTypeSearchDetails
        /*
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        
        let components = NSDateComponents()
        components.year = 1987
        components.month = 3
        components.day = 17
        components.hour = 14
        components.minute = 20
        components.second = 0
        
        let date = calendar?.dateFromComponents(components)
*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: AnyObject) {
        
        dataValidationCompletion = { success, errorMessage in
            if let errorMessage = errorMessage {
                print("\(self) \(errorMessage)")
            }
        }
        
        search.pickupDate = NSDate().addingTimeInterval(100000) as Date!
        search.dropoffDate = NSDate().addingTimeInterval(200000) as Date!
        search.driverAge = 30
        
        cartrawlerAPI?.locationSearch(withAirportCode: "DUB", completion: { (locations, error) in
            if let locations = locations {
                self.search.pickupLocation = locations.matchedLocations.first
                self.search.dropoffLocation = locations.matchedLocations.first
                DispatchQueue.main.async {
                    self.pushToDestination()
                }
            }
        })
    }
}
