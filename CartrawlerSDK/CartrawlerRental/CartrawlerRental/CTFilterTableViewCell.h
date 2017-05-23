//
//  CTFilterTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CartrawlerSDK/CTLabel.h>

@interface CTFilterTableViewCell : UITableViewCell

@property (nonatomic, readonly) CTLabel *label;

- (void)setText:(NSString *)text;

- (void)enableCheckmark:(BOOL)enableCheckmark;

- (void)cellTapped;

- (void)setup;

@end
