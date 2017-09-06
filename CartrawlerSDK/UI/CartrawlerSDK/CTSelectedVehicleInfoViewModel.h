//
//  CTSelectedVehicleInfoViewModel.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTViewModelProtocol.h"

@interface CTSelectedVehicleInfoViewModel : NSObject <CTViewModelProtocol>

@property (nonatomic, readonly) NSString *vehicleName;
@property (nonatomic, readonly) NSString *passengers;
@property (nonatomic, readonly) NSString *bags;
@property (nonatomic, readonly) NSString *doors;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *featuresCount;
@property (nonatomic, readonly) NSString *features;
@property (nonatomic, readonly) NSURL *vehicleURL;
@property (nonatomic, readonly) UIColor *primaryColor;
@property (nonatomic, readonly) NSAttributedString *freeCancellation;
@property (nonatomic, readonly) BOOL displayMerchandising;
@property (nonatomic, readonly) NSString *merchandisingText;
@property (nonatomic, readonly) UIColor *merchandisingColor;
@property (nonatomic, readonly) BOOL expandedCell;

@end
