//
//  CTCSVItem.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCSVItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;

- (id)initWithName:(NSString *)name code:(NSString *)code;

@end
