//
//  CTSpecialOffersPresentationLogic.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CTLocalisedStrings.h"
#import "CTSDKLocalizationConstants.h"

@interface CTSpecialOffersPresentationLogic : NSObject

+ (NSString *)specialOfferText:(NSArray <CTSpecialOffer *> *)specialOffers;

+ (NSString *)merchandisingText:(CTMerchandisingTag)merchandisingTag;

+ (UIColor *)merchandisingColor:(CTMerchandisingTag)merchandisingTag;

@end
