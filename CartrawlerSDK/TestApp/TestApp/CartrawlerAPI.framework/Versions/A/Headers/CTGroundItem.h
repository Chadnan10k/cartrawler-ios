//
//  CTGroundItem.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 21/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTGroundItem : NSObject

typedef NS_ENUM(NSUInteger, ServiceLevel) {
    
    ServiceLevelNone = 0,
    
    ServiceLevelEconomy,
    
    ServiceLevelStandard,
    
    ServiceLevelBusiness,
    
    ServiceLevelLuxury,
    
    ServiceLevelPremium,
    
    ServiceLevelStandardClass,
    
    ServiceLevelFirstClass
    
};

@end
