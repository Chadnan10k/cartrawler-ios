//
//  CTViewManager.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTSearch.h"
#import "CTViewController.h"

///Checks whether or not we can push to a certain view
@interface CTViewManager : NSObject

typedef void (^ValidationCompletion)(BOOL success, NSString *errorMessage);
typedef void (^VehAvailCompletion)(BOOL success, NSString *errorMessage);
typedef void (^InsuranceCompletion)(BOOL success, NSString *errorMessage);

+ (void)canTransitionToStep:(CTViewController *)step
              cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                 completion:(ValidationCompletion)completion;
@end
