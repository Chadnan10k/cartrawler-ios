//
//  CTDriverDetailsValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 23/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTValidation.h"

@interface CTDriverDetailsValidation : CTValidation

- (void)validateCarRental:(CarRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidation)completion;

@end
