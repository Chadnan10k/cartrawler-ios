//
//  LocaleUtils.h
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocaleUtils : NSObject

+ (NSString *)priceForDeviceLocale:(NSNumber *)price;

+ (void)forceLinkerLoad_;

@end
