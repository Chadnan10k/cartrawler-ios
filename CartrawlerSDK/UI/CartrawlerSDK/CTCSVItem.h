//
//  CTCSVItem.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCSVItem : NSObject

@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *code;
// TODO: Make immutable
@property (nonatomic) NSString *displayName;

- (id)initWithName:(NSString *)name code:(NSString *)code;

@end
