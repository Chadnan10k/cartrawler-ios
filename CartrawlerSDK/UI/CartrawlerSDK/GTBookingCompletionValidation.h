//
//  GTBookingCompletionValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 19/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <CartrawlerSDK/CartrawlerSDK.h>

@interface GTBookingCompletionValidation : CTValidation

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion;

@end
