//
//  CTVehicleListTableViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import <CartrawlerAPI/CTAvailabilityItem.h>
#import <UIKit/UIKit.h>

@interface CTVehicleListTableViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) NSAttributedString *vehicleName;
@property (nonatomic, readonly) NSString *passengers;
@property (nonatomic, readonly) NSString *bags;
@property (nonatomic, readonly) NSString *fuel;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSURL *vehicleURL;
@property (nonatomic, readonly) BOOL displayMerchandising;
@property (nonatomic, readonly) NSString *merchandisingText;
@property (nonatomic, readonly) UIColor *merchandisingColor;
@property (nonatomic, readonly) BOOL displaySpecialOffer;
@property (nonatomic, readonly) NSString *specialOffer;
@property (nonatomic, readonly) UIColor *specialOfferColor;
@property (nonatomic, readonly) NSURL *vendorURL;
@property (nonatomic, readonly) NSAttributedString *vendorRating;
@property (nonatomic, readonly) NSAttributedString *price;
@property (nonatomic, readonly) NSString *perDay;
@property (nonatomic, readonly) BOOL expandedCell;
@property (nonatomic, readonly) CTAvailabilityItem *availabilityItem;

+ (instancetype)viewModelForAvailabilityItem:(CTAvailabilityItem *)availabilityItem
                                  pickupDate:(NSDate *)pickupDate
                                 dropoffDate:(NSDate *)dropoffDate;

@end
