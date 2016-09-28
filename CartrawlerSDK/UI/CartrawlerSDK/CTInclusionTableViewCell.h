//
//  CTInclusionTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 28/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CTInclusionTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setLabelText:(NSString *)text;

@end
