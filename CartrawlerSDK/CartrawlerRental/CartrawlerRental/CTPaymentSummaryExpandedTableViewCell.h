//
//  CTPaymentSummaryExpandedTableViewCell.h
//  CartrawlerSDK
//
//  Created by Alan on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTLabel.h>

/**
 A cell displaying a title and cost detail
 */
@interface CTPaymentSummaryExpandedTableViewCell : UITableViewCell

@property (nonatomic, strong) CTLabel *titleLabel;

@property (nonatomic, strong) CTLabel *detailLabel;

@property (nonatomic, assign) BOOL useBoldFont;

@end
