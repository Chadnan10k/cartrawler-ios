//
//  BookingSummaryViewController.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTRentalSearch.h"
#import "CTViewController.h"

@interface CTBookingSummaryView: CTViewController

typedef void (^ CTBookingSummaryViewHeight)(CGFloat height);

@property (nonatomic) CTBookingSummaryViewHeight heightChanged;

- (void)enableScroll:(BOOL)enable;

@end
