//
//  PaymentSummaryTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 11/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerAPI/CTExtraEquipment.h>
@interface PaymentSummaryTableViewCell : UITableViewCell



- (void)setDetails:(CTExtraEquipment *)detail price:(NSNumber *)price;
- (void)setDetailsItalic:(NSString *)detail;

@end
