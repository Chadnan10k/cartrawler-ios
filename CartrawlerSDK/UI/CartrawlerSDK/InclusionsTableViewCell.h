//
//  InclusionsTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InclusionsTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setText:(NSString *)text;
@end
