//
//  InclusionCollectionViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InclusionTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setText:(NSString *)text;

@end
