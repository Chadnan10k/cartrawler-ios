//
//  CTPaymentSummaryDataSource.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTRentalSearch.h>

@interface CTPaymentSummaryDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

- (void)setData:(CTRentalSearch *)search;

@end
