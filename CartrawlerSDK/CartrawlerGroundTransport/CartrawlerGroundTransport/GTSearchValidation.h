//
//  GTSearchValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GroundTransportSearch.h"
#import "CartrawlerAPI/CartrawlerAPI.h"
#import "CTValidation.h"

@interface GTSearchValidation : CTValidation

- (void)validateGroundTransport:(GroundTransportSearch *)search
                  cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
                     completion:(CTSearchValidation)completion;

@end
