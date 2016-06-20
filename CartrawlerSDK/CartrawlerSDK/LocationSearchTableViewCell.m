//
//  LocationSearchTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 20/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "LocationSearchTableViewCell.h"
#import "CTLabel.h"

@interface LocationSearchTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;

@end

@implementation LocationSearchTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setLabelText:(NSString *)text
{
    self.locationLabel.text = text;
}

@end
