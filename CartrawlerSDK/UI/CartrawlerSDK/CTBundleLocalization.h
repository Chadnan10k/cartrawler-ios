//
//  CTBundleLocalization.h
//  CartrawlerSDK
//
//  Created by Alan on 05/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTBundleLocalization : NSObject

- (NSString *)localizedStringForKey:(NSString *)key bundle:(NSBundle *)bundle language:(NSString *)language;

@end
