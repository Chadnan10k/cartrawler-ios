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
#import "CartrawlerAPI/CTVendor.h"
#import "CartrawlerAPI/CTVendorRating.h"
#import "CTAppearance.h"
#import "NSNumberUtils.h"

@interface VehicleTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengerQtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *transmissionLabel;
@property (weak, nonatomic) IBOutlet UILabel *airconLabel;
@property (weak, nonatomic) IBOutlet UILabel *fuelPolicyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingTitle;

@end

@implementation VehicleTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)initWithVehicle:(CTVehicle *)vehicle
{
    self.vehicleNameLabel.text = vehicle.makeModelName;
    self.passengerQtyLabel.text = [NSString stringWithFormat:@"%d %@", vehicle.passengerQty.intValue, NSLocalizedString(@"passengers", @"passengers")];
    self.transmissionLabel.text = vehicle.transmissionType;
    self.fuelPolicyLabel.text = [self fuelPolicyString:vehicle.fuelPolicy];

    NSArray *priceStrings = [[NSNumberUtils numberStringWithCurrencyCode:vehicle.totalPriceForThisVehicle] componentsSeparatedByString:@"."];
    NSMutableAttributedString *priceString = [[NSMutableAttributedString alloc] init];

    NSAttributedString *dollars = [[NSAttributedString alloc] initWithString:priceStrings.firstObject
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:20]}];
    
    NSAttributedString *dot = [[NSAttributedString alloc] initWithString:@"."
                                                              attributes:@{NSFontAttributeName:
                                                                          [UIFont fontWithName:[CTAppearance instance].boldFontName size:14]}];

    NSAttributedString *cents = [[NSAttributedString alloc] initWithString:priceStrings.lastObject
                                                                attributes:@{NSFontAttributeName:
                                                                                 [UIFont fontWithName:[CTAppearance instance].boldFontName size:14]}];
    
    [priceString appendAttributedString:dollars];
    [priceString appendAttributedString:dot];
    [priceString appendAttributedString:cents];
    
    self.totalPriceLabel.attributedText = priceString;
    
    if (vehicle.vendor.rating.overallScore != nil) {
        
        NSString *score = [NSString stringWithFormat:@"%.1f", vehicle.vendor.rating.overallScore.floatValue * 2];
        
        NSMutableAttributedString *ratingString = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *rating = [[NSAttributedString alloc] initWithString:score
                                                                      attributes:@{NSFontAttributeName:
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName size:14]}];
        
        NSAttributedString *slash = [[NSAttributedString alloc] initWithString:@"/"
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:12]}];
        
        NSAttributedString *ten = [[NSAttributedString alloc] initWithString:@"10"
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].boldFontName size:12], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
        
        [ratingString appendAttributedString:rating];
        [ratingString appendAttributedString:slash];
        [ratingString appendAttributedString:ten];
        self.ratingTitle.text = NSLocalizedString(@"Rating", @"Rating");

        self.ratingLabel.attributedText = ratingString;
        
    } else {
        self.ratingTitle.text = @"";
        self.ratingLabel.text = @"";
    }

    [[CTImageCache sharedInstance] cachedImage: vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: vehicle.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
}

- (NSString *)fuelPolicyString:(FuelPolicy)fuelPolicy {
    
    if (fuelPolicy == FuelPolicyFullToFull) {
        return NSLocalizedString(@"Full to full", @"Full to full");
    }
    
    if (fuelPolicy == FuelPolicyFullEmptyRefund) {
        return NSLocalizedString(@"Full to empty refund", @"Full to empty refund");
    }
    
    if (fuelPolicy == FuelPolicyFullToEmpty) {
        return NSLocalizedString(@"Full to empty", @"Full to empty");
    }
    
    if (fuelPolicy == FuelPolicyElectricVehicle) {
        return NSLocalizedString(@"Electric vehicle", @"Electric vehicle");
    }
    
    if (fuelPolicy == FuelPolicyElectricVehicle) {
        return NSLocalizedString(@"Electric vehicle", @"Electric vehicle");
    }
    
    if (fuelPolicy == FuelPolicyEmptyToEmpty) {
        return NSLocalizedString(@"Empty to empty", @"Empty to empty");
    }
    
    if (fuelPolicy == FuelPolicyHalfToEmpty) {
        return NSLocalizedString(@"Half to empty", @"Half to empty");
    }
    
    if (fuelPolicy == FuelPolicyQuarterToEmpty) {
        return NSLocalizedString(@"Quarter to empty", @"Quarter to empty");
    }

    if (fuelPolicy == FuelPolicyHalfToHalf) {
        return NSLocalizedString(@"Half to half", @"Half to half");
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return NSLocalizedString(@"Quarter to quarter", @"Quarter to quarter");
    }
    
    if (fuelPolicy == FuelPolicyQuarterToQuarter) {
        return NSLocalizedString(@"Unknown", @"Unknown");
    }

    if (fuelPolicy == FuelPolicyFullToFullHybrid) {
        return NSLocalizedString(@"Full to full hybrid", @"Full to full hybrid");
    }

    if (fuelPolicy == FuelPolicyChaufFulFul) {
        return NSLocalizedString(@"Full to full chauf", @"Full to full chauf");
    }

    if (fuelPolicy == FuelPolicyChaufFulFul) {
        return NSLocalizedString(@"Chauf full included", @"Chauf full included");
    }

    return @"Unknown";
}

@end
