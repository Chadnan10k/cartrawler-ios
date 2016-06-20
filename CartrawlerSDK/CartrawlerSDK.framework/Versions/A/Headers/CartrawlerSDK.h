//
//  CartrawlerSDK.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "StepOneViewController.h"
#import "StepTwoViewController.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CartrawlerSDK : NSObject

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug;

- (void)presentStepOneInViewController:(UIViewController *)viewController;

/*
 *
 *  You can present any step at any time once you pass the data and your currently presented view controller.
 *
 */


- (void)presentStepTwoWithData:(NSString *)pickupLocationCode
            returnLocationCode:(NSString *)returnLocationCode
           customerCountryCode:(NSString *)customerCountryCode
                  passengerQty:(NSNumber *)passengerQty
                     driverAge:(NSNumber *)driverAge
                pickUpDateTime:(NSDate *)pickupDateTime
                returnDateTime:(NSDate *)returnDateTime
                  currencyCode:(NSString *)currencyCode
              inViewController:(UIViewController *)viewController;



/*
 *  View Controller Overriding:
 *  You can set a custom view for any step of the user journey by subclassing
 *  the designated step view controller.
 *
 *  You must set all of the properties of the step view controller in order to
 *  push to the next view.
 */

- (void)overrideStepOneViewController:(StepOneViewController *)viewController;
- (void)overrideStepTwoViewController:(StepTwoViewController *)viewController;



//Settings
- (void)changeLanguage:(NSString *)langaugeCode;
- (void)changeCurrency:(NSString *)currencyCode;

@end