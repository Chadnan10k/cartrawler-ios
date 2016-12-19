//
//  CTValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CTRentalSearch.h"
#import <CartrawlerAPI/CartrawlerAPI.h>

@interface CTValidation : NSObject
typedef void (^CTSearchValidationCompletion)(BOOL success, NSString *errorMessage, BOOL useOptionalRoute);

- (void)validateCarRental:(CTRentalSearch *)search
            cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI
               completion:(CTSearchValidationCompletion)completion;
@end

