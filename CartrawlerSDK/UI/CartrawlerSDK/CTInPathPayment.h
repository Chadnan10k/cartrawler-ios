//
//  CTInPathPayment.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CartrawlerAPI/CartrawlerAPI.h>
#import "CarRentalSearch.h"

@interface CTInPathPayment : NSObject

+ (NSDictionary *)createInPathRequest:(CarRentalSearch *)search;

@end
