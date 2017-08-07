//
//  CTSelectedVehicleIncludedViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSelectedVehicleIncludedViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) BOOL displayInsuranceView;

@property (nonatomic, readonly) NSString *pickupLocation;
@property (nonatomic, readonly) NSString *fuelPolicy;
@property (nonatomic, readonly) NSString *mileageAllowance;
@property (nonatomic, readonly) NSString *insurance;
@property (nonatomic, readonly) NSString *important;

@property (nonatomic, readonly) NSString *pickupLocationDetail;
@property (nonatomic, readonly) NSString *fuelPolicyDetail;
@property (nonatomic, readonly) NSString *mileageAllowanceDetail;
@property (nonatomic, readonly) NSString *insuranceDetail;
@property (nonatomic, readonly) NSString *importantDetail;

@property (nonatomic, readonly) BOOL pickupLocationExpanded;
@property (nonatomic, readonly) BOOL fuelPolicyExpanded;
@property (nonatomic, readonly) BOOL mileageAllowanceExpanded;
@property (nonatomic, readonly) BOOL insuranceExpanded;

@end
