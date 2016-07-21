//
//  CartrawlerSDK.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTAppearance.h"

#import "StepOneViewController.h"
#import "StepTwoViewController.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"
#import "StepFiveViewController.h"
#import "StepSixViewController.h"
#import "StepSevenViewController.h"

@interface CartrawlerSDK : NSObject

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug;

+ (CTAppearance *)appearance;

- (void)presentCarRentalInViewController:(UIViewController *)viewController;
- (void)presentGroundTransportInViewController:(UIViewController *)viewController;

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
- (void)overrideStepThreeViewController:(StepThreeViewController *)viewController;
- (void)overrideStepFourViewController:(StepFourViewController *)viewController;
- (void)overrideStepFiveViewController:(StepFiveViewController *)viewController;
- (void)overrideStepSixViewController:(StepSixViewController *)viewController;
- (void)overrideStepSevenViewController:(StepSevenViewController *)viewController;


@end
