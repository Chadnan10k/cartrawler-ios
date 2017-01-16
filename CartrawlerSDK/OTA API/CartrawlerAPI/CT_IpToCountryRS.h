//
//  CT_IpToCountryRS.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CT_IpToCountryRS : NSObject

@property (nonatomic, strong) NSString *ipAddress;
@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) NSString *engineLoadID;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end
