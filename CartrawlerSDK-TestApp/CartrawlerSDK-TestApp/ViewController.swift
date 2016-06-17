//
//  ViewController.swift
//  CartrawlerSDK-TestApp
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let api = CartrawlerSDK(requestorID: "68622", languageCode: "EN", isDebug: true)
        
//        let customStepOne = storyboard?.instantiateViewControllerWithIdentifier("CustomStepOneViewController") as! CustomStepOneViewController
//        
//        api.setCustomSearchView(customStepOne)
        
        api.presentSearchViewInViewController(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

