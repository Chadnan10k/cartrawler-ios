//
//  CTTag.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/01/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTTag.h"

@implementation CTTag

- (instancetype)init:(NSString *)name
              detail:(NSString *)detail
           container:(NSNumber *)container
           timestamp:(NSString *)timestamp
        engineLoadID:(NSString *)engineLoadID
          customerID:(NSString *)customerID
             queryID:(NSString *)queryID
                step:(NSNumber *)step;
{
    self = [super init];
    _name = name;
    _detail = detail;
    _container = container;
    _timestamp = timestamp;
    _engineLoadID = engineLoadID;
    _customerID = customerID;
    _queryID = queryID;
    _step = step;
    return self;
}

- (NSDictionary *)toDictionary
{
    return @{
             @"tag" : self.name,
             @"detail" : self.detail,
             @"container" : self.container,
             @"timestamp" : self.timestamp,
             @"id" : self.engineLoadID,
             @"cid" : self.customerID,
             @"qid" : self.queryID,
             @"step" : self.step
             };
}

- (NSArray *)toArray
{
    return @[[self toDictionary]];
}

- (NSURL *)produceURL
{
    return [CTTag produceURLForTags:@[self]];
}

+ (NSURL *)produceURLForTags:(NSArray *)tags {
    NSMutableArray *tagDictionaries = [NSMutableArray new];
    for (CTTag *tag in tags) {
        [tagDictionaries addObject:tag.toDictionary];
    }
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:tagDictionaries options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *escapedString = [jsonString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://tag.cartrawler.com/?json=1&t=%@", escapedString]];
    return url;
}

@end
