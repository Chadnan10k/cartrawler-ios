//
//  USState.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 25/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

///Abstract: Used for US insurance quotes
@interface InsuranceSelectorItem : NSObject

@property (nonatomic, strong, readonly, nonnull) NSString *name;
@property (nonatomic, strong, readonly, nonnull) NSString *code;

- (instancetype)initWithName:(NSString *)name code:(NSString *)code  ;
@end
NS_ASSUME_NONNULL_END
