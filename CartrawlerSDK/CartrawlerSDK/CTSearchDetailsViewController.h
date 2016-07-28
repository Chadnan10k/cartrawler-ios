//
//  StepOneViewController.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 16/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTViewController.h"

@interface CTSearchDetailsViewController : CTViewController

typedef void (^SearchDetailsCompletion)(BOOL success, NSString *errorMessage);

@property (nonatomic) SearchDetailsCompletion searchDetailsCompletion;

+ (void)forceLinkerLoad_;

@end
