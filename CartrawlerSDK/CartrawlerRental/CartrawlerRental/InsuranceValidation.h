//
//  InsuranceValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerSDK/CTRentalSearch.h>
#import <CartrawlerSDK/CTValidation.h>

@interface InsuranceValidation : CTValidation

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion;

@end
