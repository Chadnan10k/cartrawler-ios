//
//  CTBookingTableViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 19/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTBookingTableViewModel : NSObject <CTViewModelProtocol>
@property (nonatomic, readonly) UIColor *primaryColor;

@property (nonatomic, readonly) BOOL processing;
@property (nonatomic, readonly) NSString *topMessage;
@property (nonatomic, readonly) NSString *bottomMessage;
@property (nonatomic, readonly) NSString *scrollMessage;

@property (nonatomic, readonly) NSString *pickup;
@property (nonatomic, readonly) NSString *pickupLocation;
@property (nonatomic, readonly) NSString *pickupTime;

@property (nonatomic, readonly) NSString *dropoff;
@property (nonatomic, readonly) NSString *dropoffLocation;
@property (nonatomic, readonly) NSString *dropoffTime;

@property (nonatomic, readonly) NSString *driverDetails;
@property (nonatomic, readonly) NSString *driverName;
@property (nonatomic, readonly) NSString *driverEmail;
@property (nonatomic, readonly) NSString *driverPhoneNumber;

@property (nonatomic, readonly) NSString *insurance;
@property (nonatomic, readonly) NSString *insuranceIncluded;

@property (nonatomic, readonly) NSString *vehicleSummary;
@property (nonatomic, readonly) NSString *vehicle;
@property (nonatomic, readonly) NSString *orSimilar;
@property (nonatomic, readonly) NSString *seats;
@property (nonatomic, readonly) NSString *bags;
@property (nonatomic, readonly) NSString *doors;
@property (nonatomic, readonly) NSString *transmission;
@property (nonatomic, readonly) NSString *extraFeature;
@property (nonatomic, readonly) NSURL *vehicleURL;
@property (nonatomic, readonly) NSURL *vendorURL;

@property (nonatomic, readonly) NSString *paymentSummary;
@property (nonatomic, readonly) NSString *carRental;
@property (nonatomic, readonly) NSString *carRentalAmount;
@property (nonatomic, readonly) BOOL displayInsurance;
@property (nonatomic, readonly) NSString *insuranceCostItem;
@property (nonatomic, readonly) NSString *insuranceAmount;
@property (nonatomic, readonly) NSString *total;
@property (nonatomic, readonly) NSString *totalAmount;

@property (nonatomic, readonly) NSString *nextButton;
@end
