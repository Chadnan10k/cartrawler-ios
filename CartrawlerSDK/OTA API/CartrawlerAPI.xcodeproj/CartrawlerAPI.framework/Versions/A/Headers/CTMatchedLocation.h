//
//  VehMatchedLoc.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 13/04/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTMatchedLocation : NSObject

@property (nonatomic, readonly) BOOL isAtAirport;
@property (nonatomic, strong, readonly) NSString *airportCode;
@property (nonatomic, strong, readonly) NSString *code;
@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSString *codeContext;
@property (nonatomic, strong, readonly) NSString *addressLine;
@property (nonatomic, strong, readonly) NSString *addressCode;
@property (nonatomic, strong, readonly) NSString *addressStateCode;

- (id)initWithDictionary:(NSDictionary *)dictionary;
- (id)initWithPartialStringDictionary:(NSDictionary *)dictionary;

@end
