//
//  CTGroundBooking.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 24/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundBooking.h"

@implementation CTGroundBooking

- (instancetype)initWithDictionary:(NSDictionary *)dict;
{
    _confirmationId = dict[@"Reservation"][@"Confirmation"][@"@ID"];
    
    return self;
}

@end
