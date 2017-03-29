//
//  NSNumberUtils.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (CartrawlerSDK)

- (NSString *)numberStringWithCurrencyCode;
- (NSString *)twoDecimalPlaces;

@end
