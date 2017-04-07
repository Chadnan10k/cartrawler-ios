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
#import "CartrawlerSDK/CTImageCache.h"
#import "CartrawlerSDK/CTUpSellBanner.h"

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
    self.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *containerView = [self createContainer];
    [self addSubview:containerView];
    
    [CTLayoutManager pinView:containerView
                 toSuperView:self
                     padding:UIEdgeInsetsMake(8, 8, 8, 8)];
}

- (void)setItem:(CTAvailabilityItem *)item
{
    self.makeModelLabel.text = @"test test";
    [[CTImageCache sharedInstance] cachedImage:item.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    if (item.vehicle.merchandisingTag != CTMerchandisingTagUnknown) {
        NSNumber *indexOfView = [self.manager indexOfObject:self.bannerView];
        if (indexOfView == nil) {
            [self.manager insertViewAtIndex:0 padding:UIEdgeInsetsMake(8,8,8,8) view:self.bannerView];
        } else {

            NSLog(@"update");
        }
        
    } else{
        NSNumber *indexOfView = [self.manager indexOfObject:self.bannerView];
        if (indexOfView != nil) {
            [self.manager removeAtIndex:indexOfView.integerValue];
        }
    }
    
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
    [banner setHeightConstraint:@40 priority:@1000];
    banner.backgroundColor = [UIColor greenColor];
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    
    UIImage *icon = [UIImage imageNamed:@"banner"
                               inBundle:bundle
          compatibleWithTraitCollection:nil];
    
//    CTUpSellBanner *upSellBanner = [CTUpSellBanner new];
//    [upSellBanner setIcon:icon
//    backgroundColor:[UIColor redColor]
//          textColor:[UIColor whiteColor]];
//    
//    [upSellBanner addToSuperViewWithString:@"Test" superview:banner];
    
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
    
    _vehicleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.vehicleImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.vehicleImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.vehicleImageView.backgroundColor = [UIColor yellowColor];
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:container];
    manager.orientation = CTLayoutManagerOrientationLeftToRight;
    manager.justify = YES;
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:detailsView];
    [manager insertView:UIEdgeInsetsMake(0, 0, 0, 0) view:self.vehicleImageView];

    [container setHeightConstraint:@200 priority:@750];
    
    [manager layoutViews];
    
    return container;
}

- (UIView *)createFooterContainer
{
    UIView *container = [UIView new];
    container.translatesAutoresizingMaskIntoConstraints = NO;
    [container setHeightConstraint:@50 priority:@1000];
    container.backgroundColor = [UIColor blueColor];
    return container;
}


@end
