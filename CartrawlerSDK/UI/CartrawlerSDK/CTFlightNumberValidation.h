//
//  CTFlightNumberValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTFlightNumberValidation : NSObject

+ (BOOL)isValid:(NSString *)flightNumber;

@end
