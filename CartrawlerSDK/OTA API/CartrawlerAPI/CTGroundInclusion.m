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
    } else if ([inclusionString isEqualToString:@"@PhoneCharger"]) {
        _inclusion = InclusionPhoneCharger;
    } else if ([inclusionString isEqualToString:@"@Water"]) {
        _inclusion = InclusionWater;
    } else if ([inclusionString isEqualToString:@"@Bathroom"]) {
        _inclusion = InclusionBathroom;
    } else if ([inclusionString isEqualToString:@"@Bike"]) {
        _inclusion = InclusionBike;
    } else if ([inclusionString isEqualToString:@"@ChildSeats"]) {
        _inclusion = InclusionChildSeats;
    } else if ([inclusionString isEqualToString:@"@DriverLanguages"]) {
        _inclusion = InclusionDriverLanguages;
    } else if ([inclusionString isEqualToString:@"@Magazines"]) {
        _inclusion = InclusionMagazines;
    } else if ([inclusionString isEqualToString:@"@MakeModel"]) {
        _inclusion = InclusionMakeModel;
    } else if ([inclusionString isEqualToString:@"@OversizeLuggage"]) {
        _inclusion = InclusionOversizeLuggage;
    } else if ([inclusionString isEqualToString:@"@PhoneCharger"]) {
        _inclusion = InclusionPhoneCharger;
    } else if ([inclusionString isEqualToString:@"@PowerSocket"]) {
        _inclusion = InclusionPowerSocket;
    } else if ([inclusionString isEqualToString:@"@SMS"]) {
        _inclusion = InclusionSMS;
    } else if ([inclusionString isEqualToString:@"@Snacks"]) {
        _inclusion = InclusionSnacks;
    } else if ([inclusionString isEqualToString:@"@Tablet"]) {
        _inclusion = InclusionTablet;
    } else if ([inclusionString isEqualToString:@"@WaitMinutes"]) {
        _inclusion = InclusionWaitMinutes;
    } else if ([inclusionString isEqualToString:@"@WheelchairAccess"]) {
        _inclusion = InclusionWheelchairAccess;
    } else if ([inclusionString isEqualToString:@"@Video"]) {
        _inclusion = InclusionVideo;
    } else {
        _inclusion = InclusionUnknown;
    }
    
    return self;
}

@end
