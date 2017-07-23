//
//  CTSearchFormViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/20/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"
#import "CTSearchState.h"

@interface CTSearchFormViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) NSString *pickupLocationName;
@property (nonatomic, readonly) NSString *dropoffLocationName;

@property (nonatomic, readonly) NSString *rentalDates;

@property (nonatomic, readonly) NSString *pickupTime;
@property (nonatomic, readonly) NSString *dropoffTime;

@end
