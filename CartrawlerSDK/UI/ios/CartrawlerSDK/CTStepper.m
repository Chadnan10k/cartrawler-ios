//
//  CTStepper.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTStepper.h"
#import "CTAppearance.h"

@implementation CTStepper

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tintColor = [CTAppearance instance].textFieldTint;
}

@end
