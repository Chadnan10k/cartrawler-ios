//
//  CTVehicleDetailTableViewCell.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 06/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleDetailTableViewCell.h"
#import "CTMerhandisingBanner.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CartrawlerSDK+UIView.h"
#import "CartrawlerSDK/CartrawlerSDK+NSNumber.h"
#import "CartrawlerSDK/CTImageCache.h"
#import "CartrawlerSDK/CTUpSellBanner.h"
#import "CartrawlerSDK/CTAppearance.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CTRentalLocalizationConstants.h"

@interface CTVehicleDetailTableViewCell()

@property (nonatomic, strong) UIView *bannerView;
@property (nonatomic, strong) UILabel *makeModelLabel;
@property (nonatomic, strong) UILabel *passengerLabel;
@property (nonatomic, strong) UILabel *bagsLabel;
@property (nonatomic, strong) UILabel *fuelLabel;
@property (nonatomic, strong) UILabel *pickupLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *vehicleImageView;
@property (nonatomic, strong) UIImageView *vendorImageView;
@property (nonatomic, strong) CTUpSellBanner *upSellBanner;
@property (nonatomic, strong) CTLayoutManager *manager;

@end

@implementation CTVehicleDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    [self setup];
    return self;
}

- (void)setup
{
    _passengerLabel = [UILabel new];
    _bagsLabel = [UILabel new];
    _fuelLabel = [UILabel new];
    _pickupLabel = [UILabel new];
    _scoreLabel = [UILabel new];
    _priceLabel = [UILabel new];
    
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *containerView = [self createContainer];
    [self addSubview:containerView];
    
    [CTLayoutManager pinView:containerView
                 toSuperView:self
                     padding:UIEdgeInsetsMake(8, 8, 8, 8)];
}

- (void)setItem:(CTAvailabilityItem *)item pickupDate:(NSDate *)pickupDate dropoffDate:(NSDate *)dropoffDate;
{
    self.makeModelLabel.text = [self attributedText:item.vehicle.makeModelName boldColor:[UIColor blackColor] boldSize:17 regularText:item.vehicle.orSimilar regularColor:[UIColor lightGrayColor] regularSize:15 useSpace:YES];
    [[CTImageCache sharedInstance] cachedImage:item.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage:item.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    if (item.vehicle.merchandisingTag != CTMerchandisingTagUnknown) {
        NSNumber *indexOfView = [self.manager indexOfObject:self.bannerView];
        if (indexOfView == nil) {
            self.upSellBanner.alpha = 1;
            [self.manager insertViewAtIndex:0 padding:UIEdgeInsetsMake(8,0,8,8) view:self.bannerView];
        } else {
            self.upSellBanner.alpha = 1;
            NSLog(@"update banner text");
        }
        
    } else {
        NSNumber *indexOfView = [self.manager indexOfObject:self.bannerView];
        if (indexOfView != nil) {
            self.upSellBanner.alpha = 0;
            [self.manager removeAtIndex:indexOfView.integerValue];
        }
    }
    
    self.passengerLabel.text = @"5 passengers";
    self.bagsLabel.text = @"5 passengers";
    self.fuelLabel.text = @"5 passengers";
    self.pickupLabel.text = @"5 passengers";
    
    self.scoreLabel.attributedText = [self attributedText:[NSNumber numberWithFloat:item.vendor.rating.totalScore.floatValue/10].stringValue
                                                boldColor:[CTAppearance instance].iconTint
                                                 boldSize:17
                                              regularText:@"/10"
                                             regularColor:[UIColor lightGrayColor]
                                              regularSize:17
                                                 useSpace:NO];
    
    self.priceLabel.attributedText = [self attributedText:[item.vehicle.totalPriceForThisVehicle pricePerDay:pickupDate dropoff:dropoffDate]
                                                boldColor:[CTAppearance instance].iconTint
                                                 boldSize:21
                                              regularText:@""
                                             regularColor:[UIColor lightGrayColor]
                                              regularSize:17
                                                 useSpace:NO];

    [self updateLabelHeight:self.passengerLabel];
    [self updateLabelHeight:self.bagsLabel];
    [self updateLabelHeight:self.fuelLabel];
    [self updateLabelHeight:self.pickupLabel];
}

- (UIView *)createContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = [UIColor grayColor];
    container.layer.cornerRadius = 5;
    container.layer.borderWidth = 0.5;
    container.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    container.layer.masksToBounds = YES;
    
    _bannerView = [self createBannerContainer];
    
    _manager = [CTLayoutManager layoutManagerWithContainer:container];

    [self.manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:[self createNameContainer]];
    [self.manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:[self createDetailsBlock]];
    [self.manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:[self createFooterContainer]];

    [self.manager layoutViews];
    
    return container;
}

- (UIView *)createBannerContainer
{
    UIView *banner = [UIView new];
    banner.translatesAutoresizingMaskIntoConstraints = NO;
    [banner setHeightConstraint:@40 priority:@750];
    banner.backgroundColor = [UIColor greenColor];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    UIImage *icon = [UIImage imageNamed:@"banner"
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
    _upSellBanner = [CTUpSellBanner new];
    [self.upSellBanner setIcon:icon
    backgroundColor:[UIColor redColor]
          textColor:[UIColor whiteColor]];
    
    [self.upSellBanner addToSuperViewWithString:@"Test" superview:banner];
    return banner;
}

- (UIView *)createNameContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    _makeModelLabel = [UILabel new];
    [container addSubview:self.makeModelLabel];
    [CTLayoutManager pinView:self.makeModelLabel toSuperView:container];
    return container;
}

- (UIView *)createDetailsBlock
{
    
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    container.backgroundColor = [UIColor redColor];
    
    UIView *detailsView = [UIView new];
    detailsView.translatesAutoresizingMaskIntoConstraints = NO;
    detailsView.backgroundColor = [UIColor greenColor];
    
    CTLayoutManager *detailsViewManager = [CTLayoutManager layoutManagerWithContainer:detailsView];
    detailsViewManager.orientation = CTLayoutManagerOrientationTopToBottom;
    detailsViewManager.justify = NO;
    [detailsViewManager insertView:UIEdgeInsetsMake(8, 0, 8, 8) view:[self createImageTextView:self.passengerLabel iconName: @"people"]];
    [detailsViewManager insertView:UIEdgeInsetsMake(8, 0, 8, 8) view:[self createImageTextView:self.bagsLabel iconName: @"baggage"]];
    [detailsViewManager insertView:UIEdgeInsetsMake(8, 0, 8, 8) view:[self createImageTextView:self.fuelLabel iconName: @"fuel"]];
    [detailsViewManager insertView:UIEdgeInsetsMake(8, 0, 8, 8) view:[self createImageTextView:self.pickupLabel iconName: @"location"]];
    [detailsViewManager layoutViews];
    
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.vehicleImageView.backgroundColor = [UIColor yellowColor];
    [self.vendorImageView setHeightConstraint:@100 priority:@750];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:container];
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    manager.justify = YES;
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:detailsView];
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:self.vehicleImageView];
    
    [manager layoutViews];
    
    return container;
}

- (UIView *)createImageTextView:(UILabel *)label iconName:(NSString *)iconName
{
    UIView *view = [UIView new];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    UIImage *icon = [UIImage imageNamed:iconName
                                        inBundle:bundle
                   compatibleWithTraitCollection:nil];
    
    UIImageView *imageView = [UIImageView new];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [imageView setHeightConstraint:@20 priority:@1000];
    imageView.backgroundColor = [UIColor redColor];
    imageView.image = icon;
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.numberOfLines = 0;
    [label sizeToFit];
    [view addSubview:imageView];
    [view addSubview:label];

    NSLayoutConstraint *imageVerticalConstraint = [NSLayoutConstraint constraintWithItem:imageView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:view
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    
    NSDictionary *viewDict = @{@"imageView" : imageView, @"label" : label, @"view" : view};
    [view addConstraint:imageVerticalConstraint];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView(20)]-4-[label]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[label]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:viewDict]];

    [label setHeightConstraint:@([self textHeight:label]) priority:@1000];
    return view;
}

- (UIView *)createFooterContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [container setHeightConstraint:@50 priority:@1000];
    container.backgroundColor = [UIColor blueColor];
    
    _scoreLabel = [UILabel new];
    self.scoreLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.scoreLabel];
    
    _vendorImageView = [UIImageView new];
    self.vendorImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.vendorImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.vendorImageView];

    _priceLabel = [UILabel new];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:self.priceLabel];
    
    UILabel *perDayLabel = [UILabel new];
    perDayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [container addSubview:perDayLabel];
    perDayLabel.numberOfLines = 1;
    perDayLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
    perDayLabel.text = @"per day";
    
    NSDictionary *viewsDict = @{
                                @"scoreLabel" : self.scoreLabel,
                                @"supplierImage" : self.vendorImageView,
                                @"priceLabel" : self.priceLabel,
                                @"perDayLabel" : perDayLabel,
                                };
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[scoreLabel]-8-[supplierImage(50)]" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[priceLabel]-0-|" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[perDayLabel]-0-|" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[priceLabel]-0-[perDayLabel(15)]-4-|" options:0 metrics:nil views:viewsDict]];
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[supplierImage(20)]" options:0 metrics:nil views:viewsDict]];

    NSLayoutConstraint *scoreVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.scoreLabel
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    NSLayoutConstraint *imageVerticalConstraint = [NSLayoutConstraint constraintWithItem:self.vendorImageView
                                                                               attribute:NSLayoutAttributeCenterY
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeCenterY
                                                                              multiplier:1
                                                                                constant:0];
    
    [container addConstraints:@[scoreVerticalConstraint, imageVerticalConstraint]];
    return container;
}

- (void)updateLabelHeight:(UILabel *)label
{
    [label cartrawlerConstraintForAttribute:NSLayoutAttributeHeight].constant = [self textHeight:label];
}

- (CGFloat)textHeight:(UILabel *)label
{
    CGFloat maxWidth = (self.frame.size.width / 2) - 48; //the 48 accounts for the padding trailing and leading to the label
    CGRect rect = [label.text boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX)
                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                  attributes:@{NSFontAttributeName:label.font}
                                     context:nil];
    CGFloat textHeight = rect.size.height;
    return ceil(textHeight);
}

- (NSAttributedString *)attributedText:(NSString *)boldText boldColor:(UIColor *)boldColor boldSize:(CGFloat)boldSize regularText:(NSString *)regularText regularColor:(UIColor *)regularColor regularSize:(CGFloat)regularSize useSpace:(BOOL)useSpace
{
    NSMutableAttributedString *mutableString = [NSMutableAttributedString new];
    
    NSAttributedString *boldString = [[NSAttributedString alloc] initWithString:boldText attributes:@{NSForegroundColorAttributeName : boldColor, NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].boldFontName size:boldSize]}];
    NSAttributedString *spaceString = [[NSAttributedString alloc] initWithString:@" "];
    NSAttributedString *regString = [[NSAttributedString alloc] initWithString:regularText attributes:@{NSForegroundColorAttributeName : regularColor, NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:regularSize]}];

    [mutableString appendAttributedString:boldString];
    
    if (useSpace)
        [mutableString appendAttributedString:spaceString];
    
    [mutableString appendAttributedString:regString];

    return mutableString;
}

@end
