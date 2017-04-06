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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *containerView = [self createContainer];
    [self addSubview:containerView];
    
    [CTLayoutManager pinView:containerView
                 toSuperView:self
                     padding:UIEdgeInsetsMake(8, 8, 8, 8)];
}

- (void)setItem:(CTAvailabilityItem *)item
{
    self.makeModelLabel = @"test test";
    [[CTImageCache sharedInstance] cachedImage:item.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
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
    
    CTLayoutManager *manager = [CTLayoutManager layoutManagerWithContainer:container];
    
    [manager insertView:UIEdgeInsetsMake(8, 0, 8, 8) view:[self createBannerContainer]];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:[self createNameContainer]];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:[self createDetailsBlock]];
    [manager insertView:UIEdgeInsetsMake(8, 8, 8, 8) view:[self createFooterContainer]];

    [manager layoutViews];
    
    return container;
}

- (UIView *)createBannerContainer
{
    _bannerView = [UIView new];
    self.bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.bannerView setHeightConstraint:@40 priority:@1000];
    self.bannerView.backgroundColor = [UIColor greenColor];
    return self.bannerView;
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

    [container setHeightConstraint:@200 priority:@1000];
    
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
