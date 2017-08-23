//
//  CTSelectedVehicleInsuranceDetailsViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 23/08/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSelectedVehicleInsuranceDetailsViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *logo;
@property (nonatomic, readonly) NSString *perDay;
@property (nonatomic, readonly) NSString *total;
@property (nonatomic, readonly) NSString *reduceLiability;
@property (nonatomic, readonly) NSString *reduceLiabilityDetails;
@property (nonatomic, readonly) NSString *whatsCovered;
@property (nonatomic, readonly) NSAttributedString *whatsCoveredDetails;
@property (nonatomic, readonly) NSString *termsAndConditions;

@end
