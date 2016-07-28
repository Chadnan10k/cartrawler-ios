//
//  StepThreeViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CTViewController.h"

@interface StepThreeViewController : CTViewController

//Used for when the insurance details api call fails or succeeds
typedef void (^StepThreeCompletion)(BOOL success, NSString *errorMessage);

@property (nonatomic) StepThreeCompletion stepThreeCompletion;

+ (void)forceLinkerLoad_;

@end
