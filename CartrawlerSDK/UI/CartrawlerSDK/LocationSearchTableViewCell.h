//
//  LocationSearchTableViewCell.h
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationSearchTableViewCell : UITableViewCell

+ (void)forceLinkerLoad_;

- (void)setLabelText:(NSString *)text isAirport:(BOOL)isAirport;

@end
