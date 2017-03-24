//
//  CTMerhandisingBanner.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTVehicle.h>

@interface CTMerhandisingBanner : UIView

- (void)setBanner:(CTMerchandisingTag)merchandisingTag specialOffers:(NSArray <CTSpecialOffer *> *)specialOffers;
- (void)setSpecialOffer:(NSString *)offerText;

@end
