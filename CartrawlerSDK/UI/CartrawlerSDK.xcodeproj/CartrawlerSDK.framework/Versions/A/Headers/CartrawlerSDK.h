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

@interface CartrawlerSDK : NSObject

- (id)initWithRequestorID:(NSString *)requestorID
             languageCode:(NSString *)languageCode
                  isDebug:(BOOL)isDebug;

//you can present any step at any time once you pass the data

- (void)presentSearchViewInViewController:(UIViewController *)viewController;
- (void)presentSearchResultsView;

//experimental
//This should all be done before presenting any views
- (void)setCustomSearchView:(StepOneViewController *)viewController;
- (void)setStepTwoViewController:(StepTwoViewController *)viewController;

- (StepTwoViewController *)searchResultsController;

@end