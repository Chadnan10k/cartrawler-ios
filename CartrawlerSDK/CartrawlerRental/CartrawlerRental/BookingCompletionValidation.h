//
//  BookingCompletionValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 19/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <CartrawlerSDK/CartrawlerSDK.h>

@interface BookingCompletionValidation : CTValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion;

@end
