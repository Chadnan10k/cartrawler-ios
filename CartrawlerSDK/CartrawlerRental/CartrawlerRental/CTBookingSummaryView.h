//
//  BookingSummaryViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTRentalSearch.h>
#import <CartrawlerSDK/CTViewController.h>

@interface CTBookingSummaryView: CTViewController

typedef void (^ CTBookingSummaryViewHeight)(CGFloat height);

@property (nonatomic) CTBookingSummaryViewHeight heightChanged;

- (void)enableScroll:(BOOL)enable;

@end
