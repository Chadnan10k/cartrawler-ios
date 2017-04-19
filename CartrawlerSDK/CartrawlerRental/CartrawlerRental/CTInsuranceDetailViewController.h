//
//  CTExtrasViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <CartrawlerSDK/CTViewController.h>

@class CTInsuranceDetailViewController;

@protocol CTInsuranceDetailDelegate <NSObject>

- (void)didTapAddInsurance:(CTInsuranceDetailViewController *)detailViewController;

@end

@interface CTInsuranceDetailViewController : CTViewController

@property (nonatomic, weak) id<CTInsuranceDetailDelegate> insuranceDetailDelegate;

@end
