//
//  CTTag.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTTag : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSNumber *container;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *engineLoadID;
@property (nonatomic, strong) NSString *customerID;
@property (nonatomic, strong) NSString *queryID;
@property (nonatomic, strong) NSNumber *step;

- (instancetype)init:(NSString *)name
              detail:(NSString *)detail
           container:(NSNumber *)container
           timestamp:(NSString *)timestamp
        engineLoadID:(NSString *)engineLoadID
          customerID:(NSString *)customerID
             queryID:(NSString *)queryID
                step:(NSNumber *)step;

- (NSURL *)produceURL;

+ (NSURL *)produceURLForTags:(NSArray *)tags;

@end
