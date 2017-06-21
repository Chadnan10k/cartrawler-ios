//
//  CTFreeCancelationAlertView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 15/05/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTFreeCancelationAlertView.h"
#import "CartrawlerSDK/CTLabel.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CTRentalLocalizationConstants.h"

@implementation CTFreeCancelationAlertView

- (instancetype)init
{
    self = [super init];
    
    CTLabel *detail1 = [[CTLabel alloc] init:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    detail1.numberOfLines = 0;
    detail1.text = CTLocalizedString(CTRentalFreeCancelationPoint1);
    
    UIView *separator = [UIView new];
    separator.translatesAutoresizingMaskIntoConstraints = NO;
    [separator setHeightConstraint:@0.5 priority:@1000];
    separator.backgroundColor = [UIColor darkGrayColor];
    
    CTLabel *detail2 = [[CTLabel alloc] init:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft boldFont:NO];
    detail2.numberOfLines = 0;
    detail2.text = CTLocalizedString(CTRentalFreeCancelationPoint2);
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:self];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:detail1];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:separator];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:detail2];
    [manager layoutViews];
    
    return self;
}

@end
