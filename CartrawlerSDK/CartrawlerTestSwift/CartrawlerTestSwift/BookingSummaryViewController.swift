//
//  BookingSummaryViewController.swift
//  CartrawlerTestSwift
//
//  Created by Lee Maguire on 16/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

import UIKit

class BookingSummaryViewController: CTViewController {

    @IBOutlet weak var vehicleImageView: UIImageView!
    @IBOutlet weak var vehicleNameLabel: UILabel!
    @IBOutlet weak var supplierNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vehicleNameLabel.text = search.selectedVehicle.vehicle.makeModelName
        supplierNameLabel.text = search.selectedVehicle.vendor.name
        
        //called when pushToDestination() fails so you can display an error to user
        dataValidationCompletion = { success, errorMessage in
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func back(_ sender: AnyObject) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func next(_ sender: AnyObject) {
        pushToDestination()
    }
    
}
