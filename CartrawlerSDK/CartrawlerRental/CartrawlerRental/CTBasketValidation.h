//
//  CTBasketValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 21/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerSDK/CTValidation.h>

@interface CTBasketValidation : CTValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion;

@end
