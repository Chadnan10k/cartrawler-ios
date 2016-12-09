//
//  CTTagManager.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 09/12/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTTagManager : NSObject

/*
 For In Path Bookings
*/
+ (void)didRemoveInPathVehicle;
+ (void)didBookInPathWithSuccess;
+ (void)didBookInPathWithError:(NSString *)error;

@end
