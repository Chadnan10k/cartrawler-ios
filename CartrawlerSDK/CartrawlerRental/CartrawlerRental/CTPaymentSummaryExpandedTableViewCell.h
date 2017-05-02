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

@property (nonatomic, readonly) CTLabel *titleLabel;
@property (nonatomic, readonly) CTLabel *detailLabel;

/**
 Update the cell with a CTFee, CTInsurance, CTExtraEquipment or NSString

 @param model a model
 */
- (void)updateWithModel:(id)model;

@end
