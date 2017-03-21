//
//  CTSpecialOffers.m
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSpecialOffer.h"

@implementation CTSpecialOffer

/*
 "SpecialOffers": {
 "Offer": {
 "@Type": "new_cars",
 "@ShortText": "Guaranteed 2016 - registered car",
 "@UIToken": "new_cars",
 "#text": "We guarantee that you are going to get a 2016-registered car at the desk."
 }
 },
 */

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [super init];
    _type = dict[@"Offer"][@"@Type"];
    _shortText = dict[@"Offer"][@"@ShortText"];
    _uiToken = dict[@"Offer"][@"@UIToken"];
    _text = dict[@"Offer"][@"#text"];
    return self;

}

@end
