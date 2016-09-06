//
//  GTSelectionValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <CartrawlerSDK/CartrawlerSDK.h>
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface GTSelectionValidation : CTValidation

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion;

@end
