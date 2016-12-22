//
//  CTPaymentVehicleTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentVehicleTableViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import "CTVehicleFeaturesDataSource.h"
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CartrawlerSDK+UIView.h>

@interface CTPaymentVehicleTableViewCell()


@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet CTLabel *orSimilarLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UITableView *featuresTableView;

@property (nonatomic, strong) CTVehicleFeaturesDataSource *vehicleFeaturesDataSource;

@end

@implementation CTPaymentVehicleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CTRentalSearch *)search
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [[CTImageCache sharedInstance] cachedImage: search.selectedVehicle.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: search.selectedVehicle.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    self.vehicleNameLabel.text = search.selectedVehicle.vehicle.makeModelName;
    
    NSMutableArray *featureData = [[NSMutableArray alloc] init];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        search.selectedVehicle.vehicle.passengerQty.stringValue,
                                        NSLocalizedString(@"passengers", @"passengers")],
                             @"image" : @"people"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        search.selectedVehicle.vehicle.baggageQty.stringValue,
                                        NSLocalizedString(@"bags", @"bags")],
                             @"image" : @"baggage"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@ %@",
                                        search.selectedVehicle.vehicle.doorCount.stringValue,
                                        NSLocalizedString(@"doors", @"doors")],
                             @"image" : @"doors"}];
    
    [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@",
                                        search.selectedVehicle.vehicle.transmissionType],
                             @"image" : @"gears"}];
    
    if (search.selectedVehicle.vehicle.isAirConditioned) {
        [featureData addObject:@{@"text" : [NSString stringWithFormat:@"%@",
                                            NSLocalizedString(@"Air Conditioning", @"Air Conditioning")],
                                 @"image" : @"aircon"}];
    }
    
    _vehicleFeaturesDataSource = [[CTVehicleFeaturesDataSource alloc] init];
    [self.vehicleFeaturesDataSource setData:featureData];
    self.featuresTableView.dataSource = self.vehicleFeaturesDataSource;
    [self.featuresTableView reloadData];
    [self.featuresTableView layoutIfNeeded];
    [self.featuresTableView cartrawlerConstraintForAttribute:NSLayoutAttributeHeight].constant = self.featuresTableView.contentSize.height;
}

@end
