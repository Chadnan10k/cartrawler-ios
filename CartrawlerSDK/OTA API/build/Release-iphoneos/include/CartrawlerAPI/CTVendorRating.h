//
//  CTVendorRating.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  CTVendorRating
 */
@interface CTVendorRating : NSObject

/**
 *  The vendor agent
 */
@property (nonatomic, strong, readonly) NSString *agent;
/**
 *  The average wait time
 */
@property (nonatomic, strong, readonly) NSString *averageWaitTime;
/**
 *  The car review rating
 */
@property (nonatomic, strong, readonly) NSString *carReview;
/**
 *  The desk review rating
 */
@property (nonatomic, strong, readonly) NSString *deskReview;
/**
 *  The drop off experience rating
 */
@property (nonatomic, strong, readonly) NSString *dropoffReview;
/**
 *  The location code for the vendor
 */
@property (nonatomic, strong, readonly) NSString *locationCode;
/**
 *  The name of the vendor
 */
@property (nonatomic, strong, readonly) NSString *vendorName;
/**
 *  The overall score for the vendor
 */
@property (nonatomic, strong, readonly) NSString *overallScore;
/**
 *  The pickup score for the vendor
 */
@property (nonatomic, strong, readonly) NSString *pickupScore;
/**
 *  The score for the price the vendor gives
 */
@property (nonatomic, strong, readonly) NSString *priceScore;
/**
 *  The total score of the vendor
 */
@property (nonatomic, strong, readonly) NSString *totalScore;
/**
 *  The total number of reviews this vendor has
 */
@property (nonatomic, strong, readonly) NSString *totalReviews;
/**
 *  The wait time for this vendor
 */
@property (nonatomic, strong, readonly) NSString *waitTime;

- (id)initFromDictionary:(NSDictionary *)dict;

@end
