//
//  InsuranceLink.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 25/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

///Abstract: Used for US insurance quotes
@interface InsuranceLink : NSObject

@property (nonatomic, strong, readonly, nonnull) NSURL *link;
@property (nonatomic, strong, readonly, nonnull) NSString *title;
@property (nonatomic, strong, readonly, nonnull) NSString *code;

- (instancetype)initWithLink:(NSString *)link title:(NSString *)title code:(NSString *)code  ;
@end
NS_ASSUME_NONNULL_END
