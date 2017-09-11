//
//  CTAPIState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTAvailabilityItem.h"
#import "CTTermsAndConditions.h"
#import "CTTermAndCondition.h"

// TODO: Move API state to step states
@interface CTAPIState : NSObject

@property (nonatomic) NSString *engineLoadID;
@property (nonatomic) NSString *queryID;
@property (nonatomic) NSString *customerID;

@property (nonatomic) NSMutableDictionary *matchedLocations;

@property (nonatomic) NSString *availabilityRequestTimestamp;
@property (nonatomic) NSDictionary *matchedAvailabilityItems;

@property (nonatomic) CTTermsAndConditions *termsAndConditions;

@end
