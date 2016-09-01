//
//  GooglePlaceService.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 01/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GooglePlaceService : NSObject 

typedef void (^GooglePlaceCompletion)(BOOL success, NSArray *results);

+ (void)searchWithPartialString:(NSString *)partialString completion:(GooglePlaceCompletion)completion;

@end
