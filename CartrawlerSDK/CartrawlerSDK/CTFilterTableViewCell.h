//
//  CTFilterTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTFilterTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setText:(NSString *)text;

- (void)enableCheckmark:(BOOL)enableCheckmark;

- (void)cellTapped;

@end
