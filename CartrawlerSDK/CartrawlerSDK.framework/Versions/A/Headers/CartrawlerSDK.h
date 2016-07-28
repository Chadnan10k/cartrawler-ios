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

#import "CTSearchDetailsViewController.h"
#import "StepTwoViewController.h"
#import "StepThreeViewController.h"
#import "StepFourViewController.h"
#import "StepFiveViewController.h"
#import "StepSixViewController.h"
#import "StepSevenViewController.h"

@interface CartrawlerSDK : NSObject

/**
 *  Initialize the CartrawlerAPI
 *
 *  @param requestorID  Your requester ID
 *  @param languageCode The initial language code eg. EN
 *  @param isDebug      Flag to indicate if you want to point to test or production endpoints
 *
 */
- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug;

/**
 *  Use CTAppearance for overriding the preset views color scheme
 *
 */
+ (CTAppearance *)appearance;

/**
 *  Presents the car rental engine modally in the designated UIViewController
 *
 *  @param viewController The parent view controller
 */
- (void)presentCarRentalInViewController:(UIViewController *)viewController;

/**
 *  Presents the ground transport engine modally in the designated UIViewController
 *
 *  @param viewController v
 */
- (void)presentGroundTransportInViewController:(UIViewController *)viewController;

/*
 *  View Controller Overriding:
 *  You can set a custom view for any step of the user journey by subclassing
 *  the designated step view controller.
 *
 *  You must set all of the properties of the step view controller in order to
 *  push to the next view.
 */
- (void)overrideStepOneViewController:(CTSearchDetailsViewController *)viewController;
- (void)overrideStepTwoViewController:(StepTwoViewController *)viewController;
- (void)overrideStepThreeViewController:(StepThreeViewController *)viewController;
- (void)overrideStepFourViewController:(StepFourViewController *)viewController;
- (void)overrideStepFiveViewController:(StepFiveViewController *)viewController;
- (void)overrideStepSixViewController:(StepSixViewController *)viewController;
- (void)overrideStepSevenViewController:(StepSevenViewController *)viewController;


@end
