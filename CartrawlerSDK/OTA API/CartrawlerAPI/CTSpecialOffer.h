//
//  CTSpecialOffers.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 01/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTSpecialOffer : NSObject

@property (nonatomic, nonnull, readonly) NSString *type;
@property (nonatomic, nonnull, readonly) NSString *shortText;
@property (nonatomic, nonnull, readonly) NSString *uiToken;
@property (nonatomic, nonnull, readonly) NSString *text;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

