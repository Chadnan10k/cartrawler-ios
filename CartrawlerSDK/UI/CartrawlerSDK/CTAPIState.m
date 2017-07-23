//
//  CTAPIState.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTAPIState.h"

@implementation CTAPIState

- (instancetype)init {
    self = [super init];
    if (self) {
        self.matchedLocations = [NSMutableDictionary new];
    }
    return self;
}

@end
