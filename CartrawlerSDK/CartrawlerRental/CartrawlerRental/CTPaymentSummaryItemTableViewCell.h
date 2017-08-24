//
//  CTPaymentSummaryTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTExtraEquipment.h"
@interface CTPaymentSummaryItemTableViewCell : UITableViewCell

- (void)setDetails:(CTExtraEquipment *)detail price:(NSNumber *)price;
- (void)setDetailsItalic:(NSString *)detail;

@end
