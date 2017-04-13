//
//  CTExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInsuranceViewController.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CartrawlerSDK+UIImageView.h"
#import "CartrawlerSDK/CTAppearance.h"
#import "CartrawlerSDK/CTLabel.h"

@interface CTInsuranceViewController ()

@end

@implementation CTInsuranceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:self.view];
    
    [layoutManager layoutViews];
    
}

- (UIView *)imageAndTextView:(NSString *)imageName text:(NSString *)text
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLayoutManager *layoutManager = [CTLayoutManager layoutManagerWithContainer:view];
    layoutManager.orientation = CTLayoutManagerOrientationLeftToRight;
    layoutManager.justify = NO;
    
    UIImageView *imageView = [UIImageView new];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *icon = [UIImage imageNamed:imageName
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    imageView.image = icon;
    
    [imageView setHeightConstraint:@15 priority:@100];
    [imageView setWidthConstraint:@15 priority:@1000];
    [imageView applyTintWithColor:[CTAppearance instance].iconTint];
    
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = text;
    label.numberOfLines = 0;
    
    [layoutManager insertView:UIEdgeInsetsMake(0,4,0,16) view:imageView];
    [layoutManager insertView:UIEdgeInsetsMake(0,16,0,4) view:label];
    
    [layoutManager layoutViews];
    
    return view;
}

- (UIView *)logoAndPrice
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UIImage *logo = [UIImage imageNamed:@"axa_logo"
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.image = logo;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setHeightConstraint:@40 priority:@1000];
    
    UIView *textContainer = [UIView new];
    textContainer.translatesAutoresizingMaskIntoConstraints = NO;
    [textContainer setHeightConstraint:@40 priority:@1000];
    
    CTLabel *perDayLabel = [[CTLabel alloc] init:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentRight boldFont:YES];
    perDayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    perDayLabel.text = @"$100.00 per day";
    
    CTLabel *totalLabel = [[CTLabel alloc] init:15 textColor:[UIColor lightGrayColor] textAlignment:NSTextAlignmentRight boldFont:NO];
    totalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    totalLabel.text = @"Total $30.00";
    
    CTLayoutManager *priceManager = [CTLayoutManager layoutManagerWithContainer:textContainer];
    priceManager.orientation = CTLayoutManagerOrientationTopToBottom;
    priceManager.justify = YES;
    
    [priceManager insertView:UIEdgeInsetsMake(0,0,0,0) view:perDayLabel];
    [priceManager insertView:UIEdgeInsetsMake(0,0,0,0) view:totalLabel];
    
    [priceManager layoutViews];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:view];
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    manager.justify = YES;
    
    [manager insertView:UIEdgeInsetsMake(0,0,0,0) view:imageView];
    [manager insertView:UIEdgeInsetsMake(0,0,0,0) view:textContainer];
    
    [manager layoutViews];
    
    return view;
}

- (IBAction)addInsurance:(id)sender
{
    [[CTAnalytics instance] tagScreen:@"ins_click" detail:@"1" step:@4];
    [self.search setIsBuyingInsurance:YES];
    [self pushToDestination];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Analytics

- (void)tagScreen
{
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicles-e" step:@4];
    [[CTAnalytics instance] tagScreen:@"ins_offer" detail:@"yes" step:@4];
    [self sendEvent:NO customParams:@{@"eventName" : @"Insurance & Extras Step",
                                      @"stepName" : @"Step4",
                                      @"insuranceOffered" : @"true"
                                      } eventName:@"Step of search" eventType:@"Step"];
}

@end
