//
//  CTVendorRating.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVendorRating.h"

@implementation CTVendorRating

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

    _agent           = [numFormatter numberFromString: dict[@"@agent"]];
    _averageWaitTime = [numFormatter numberFromString: dict[@"@ave_wait_mins"]];
    _carReview       = [numFormatter numberFromString: dict[@"@car_review"]];
    _deskReview      = [numFormatter numberFromString: dict[@"@desk_review"]];
    _dropoffReview   = [numFormatter numberFromString: dict[@"@dropoff_review"]];
    _locationCode    = [numFormatter numberFromString: dict[@"@location"]];
    _vendorName      = dict[@"@name"];
    _overallScore    = [numFormatter numberFromString: dict[@"@overall"]];
    _pickupScore     = [numFormatter numberFromString: dict[@"@overall_review"]];
    _priceScore      = [numFormatter numberFromString: dict[@"@pickup_review"]];
    _totalScore      = [numFormatter numberFromString: dict[@"@price_review"]];
    _totalReviews    = [numFormatter numberFromString: dict[@"@total_agent"]];
    _waitTime        = [numFormatter numberFromString: dict[@"@wait_time"]];
    
    return self;
}

@end
