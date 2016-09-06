//
//  CTValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroundTransportSearch.h"
#import "CarRentalSearch.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CTValidation : NSObject
typedef void (^CTSearchValidation)(id success, NSString *errorMessage);

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion;

- (void)validateCarRental:(CarRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion;
@end

