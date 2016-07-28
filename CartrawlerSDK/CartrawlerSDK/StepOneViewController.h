//
//  StepOneViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTViewController.h"

@interface StepOneViewController : CTViewController

typedef void (^StepOneCompletion)(BOOL success, NSString *errorMessage);

@property (nonatomic) StepOneCompletion stepOneCompletion;

- (void)pushToStepTwo;

+ (void)forceLinkerLoad_;

@end
