//
//  CTVendorRating.h
//  CartrawlerAPI
//
//  Created by Lee Maguire on 19/05/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  CTVendorRating
 */
@interface CTVendorRating : NSObject

/**
 *  The vendor agent
 */
@property (nonatomic, nonnull, readonly) NSNumber *agent;
/**
 *  The average wait time
 */
@property (nonatomic, nonnull, readonly) NSNumber *averageWaitTime;
/**
 *  The car review rating
 */
@property (nonatomic, nonnull, readonly) NSNumber *carReview;
/**
 *  The desk review rating
 */
@property (nonatomic, nonnull, readonly) NSNumber *deskReview;
/**
 *  The drop off experience rating
 */
@property (nonatomic, nonnull, readonly) NSNumber *dropoffReview;
/**
 *  The location code for the vendor
 */
@property (nonatomic, nonnull, readonly) NSNumber *locationCode;
/**
 *  The name of the vendor
 */
@property (nonatomic, nonnull, readonly) NSString *vendorName;
/**
 *  The overall score for the vendor
 */
@property (nonatomic, nonnull, readonly) NSNumber *overallScore;
/**
 *  The pickup score for the vendor
 */
@property (nonatomic, nonnull, readonly) NSNumber *pickupScore;
/**
 *  The score for the price the vendor gives
 */
@property (nonatomic, nonnull, readonly) NSNumber *priceScore;
/**
 *  The total score of the vendor
 */
@property (nonatomic, nonnull, readonly) NSNumber *totalScore;
/**
 *  The total number of reviews this vendor has
 */
@property (nonatomic, nonnull, readonly) NSNumber *totalReviews;
/**
 *  The wait time for this vendor
 */
@property (nonatomic, nonnull, readonly) NSNumber *waitTime;

- (instancetype)initFromDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END

