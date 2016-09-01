//
//  GTInclusion.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTInclusion : NSObject

typedef NS_ENUM(NSUInteger, Inclusion) {
    
    InclusionAirCon = 0,
    
    InclusionBathroom,
    
    InclusionBike,
    
    InclusionChildSeats,
    
    InclusionDriverLanguages,
    
    InclusionExtraPrivacyLegroom,
    
    InclusionMagazines,
    
    InclusionMakeModel,
    
    InclusionNewspaper,
    
    InclusionOversizeLuggage,
    
    InclusionPhoneCharger,
    
    InclusionPowerSocket,
    
    InclusionSMS,
    
    InclusionSnacks,
    
    InclusionTablet,
    
    InclusionWaitMinutes,
    
    InclusionWheelchairAccess,
    
    InclusionWifi,
    
    InclusionWorkTable,
    
    InclusionVideo,
    
    InclusionWater
    
};

@property (nonatomic, readonly) Inclusion inclusion;

- (instancetype)initFromInclusionString:(NSString *)inclusionString;

@end

NS_ASSUME_NONNULL_END
