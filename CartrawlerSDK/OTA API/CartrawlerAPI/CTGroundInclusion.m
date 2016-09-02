//
//  GTInclusion.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTGroundInclusion.h"

@implementation CTGroundInclusion

- (instancetype)initFromInclusionString:(NSString *)inclusionString
{
    self = [super init];
    
    if ([inclusionString isEqualToString:@"@AirCon"]) {
        _inclusion = InclusionAirCon;
    } else if ([inclusionString isEqualToString:@"@ExtraPrivacyAndLegRoom"]) {
        _inclusion = InclusionExtraPrivacyLegroom;
    } else if ([inclusionString isEqualToString:@"@Newspaper"]) {
        _inclusion = InclusionNewspaper;
    } else if ([inclusionString isEqualToString:@"@PowerSocket"]) {
        _inclusion = InclusionPowerSocket;
    } else if ([inclusionString isEqualToString:@"@Wifi"]) {
        _inclusion = InclusionWifi;
    } else if ([inclusionString isEqualToString:@"@WorkTable"]) {
        _inclusion = InclusionWorkTable;
    } else {
        //TODO: Include the rest
        _inclusion = nil;
    }
    
    return self;
}

@end
