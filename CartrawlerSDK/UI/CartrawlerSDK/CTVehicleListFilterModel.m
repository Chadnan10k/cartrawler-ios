//
//  CTVehicleListFilterModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListFilterModel.h"

@implementation CTVehicleListFilterModel

- (instancetype)initWithFilterType:(CTVehicleListFilterType)filterType code:(id)code {
    self = [super init];
    if (self) {
        _filterType = filterType;
        _code = code;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[CTVehicleListFilterModel class]]) {
        return NO;
    }
    
    CTVehicleListFilterModel *cast = (CTVehicleListFilterModel *)object;
    
    if ([self.code.class isKindOfClass:cast.code.class]) {
        return NO;
    }
    
    BOOL equalCode = NO;
    
    if ([self.code isKindOfClass:NSNumber.class]) {
        equalCode = [self.code isEqual:cast.code];
    }
    
    if ([self.code isKindOfClass:NSString.class]) {
        equalCode = [self.code isEqualToString:cast.code];
    }
    
    return (self.filterType == cast.filterType) && equalCode;
}

- (NSUInteger)hash {
    return [@(self.filterType) hash] ^ [self.code hash];
}

@end
