//
//  VehicleTableViewCell.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleTableViewCell.h"
#import "LocaleUtils.h"
#import "CTImageCache.h"

@interface VehicleTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *vehicleTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerQtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *baggageQtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *doorCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *pickupTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelPolicyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;

@end

@implementation VehicleTableViewCell

- (void)initWithVehicle:(CTVehicle *)vehicle
{
    self.vehicleNameLabel.text = vehicle.vehicleMakeModelName;
    self.vehicleTypeLabel.text = vehicle.vehicleCategory;
    self.totalPriceLabel.text = [LocaleUtils priceForDeviceLocale: vehicle.totalPriceForThisVehicle];
    self.passengerQtyLabel.text = [NSString stringWithFormat:@"x%@", vehicle.passengerQty.stringValue];
    self.baggageQtyLabel.text = [NSString stringWithFormat:@"x%@", vehicle.baggageQty.stringValue];
    self.doorCountLabel.text = [NSString stringWithFormat:@"x%@", vehicle.doorCount.stringValue];
    self.fuelPolicyLabel.text = vehicle.fuelPolicy;
    
    [[CTImageCache sharedInstance] cachedImage: vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
}

@end
