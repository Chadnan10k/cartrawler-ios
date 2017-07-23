//
//  CTAPIState.h
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/19/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTAPIState : NSObject

@property (nonatomic) NSString *engineLoadID;
@property (nonatomic) NSString *queryID;
@property (nonatomic) NSString *customerID;

@property (nonatomic) NSMutableDictionary *matchedLocations;

@end
