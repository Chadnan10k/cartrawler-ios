//
//  SearchValidation.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 24/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarRentalSearch.h"

@interface SearchValidation : NSObject

+ (BOOL)validate:(CarRentalSearch *)search;

@end
