//
//  VehicleTableViewCell.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 02/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleTableViewCell.h"
#import "CTImageCache.h"
#import "CartrawlerAPI/CTVendor.h"
#import "CartrawlerAPI/CTVendorRating.h"
#import "CTAppearance.h"
#import "CartrawlerSDK+NSNumber.h"
#import "CTLabel.h"
#import "LocalisedStrings.h"
#import "CTMerhandisingBanner.h"

@interface VehicleTableViewCell ()

@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengerQtyLabel;
@property (weak, nonatomic) IBOutlet CTLabel *transmissionLabel;
@property (weak, nonatomic) IBOutlet CTLabel *pickupLabel;
@property (weak, nonatomic) IBOutlet CTLabel *fuelPolicyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet UIImageView *vendorImageView;
//@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
//@property (weak, nonatomic) IBOutlet UILabel *ratingTitle;
@property (weak, nonatomic) IBOutlet UIImageView *airconImageView;
@property (weak, nonatomic) IBOutlet CTMerhandisingBanner *merchBannerView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalPriceBottomConstranit;
@property (weak, nonatomic) IBOutlet CTMerhandisingBanner *specialOfferBannerView;

@end

@implementation VehicleTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.headerView.backgroundColor = [CTAppearance instance].vehicleCellTint;
}

- (void)initWithVehicle:(CTAvailabilityItem *)item index:(NSInteger)index;
{
    
    if (index == 0 || index == 1) {
        [self.merchBannerView setBannerType:CTMerhandisingBannerTypeBestSeller];
    } else if (index == 2 || index == 3) {
        [self.merchBannerView setBannerType:CTMerhandisingBannerTypeGreatValue];
    } else {
        [self.merchBannerView setBannerType:CTMerhandisingBannerTypeNone];
    }
    
    //Do we display special offer? or any extras included in the price?
//    for (CTSpecialOffer *so in item.vehicle.specialOffers) {
//        NSLog(@"%@", so.shortText);
//    }
    
    [self.specialOfferBannerView setBannerType:CTMerhandisingBannerTypeNone];
    self.totalPriceBottomConstranit.constant = 8;
    for (CTExtraEquipment *ee in item.vehicle.extraEquipment) {
        if (ee.isIncludedInRate) {
            [self.specialOfferBannerView setSpecialOffer:ee.equipDescription];
            self.totalPriceBottomConstranit.constant = 44;
            break;
        }
    }

    NSMutableAttributedString *vehicleName = [[NSMutableAttributedString alloc] init];
    
    NSAttributedString *name = [[NSAttributedString alloc] initWithString:item.vehicle.makeModelName
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:15]}];
    
    NSAttributedString *orSimilar = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@", item.vehicle.orSimilar]
                                                              attributes:@{NSFontAttributeName:
                                                                               [UIFont fontWithName:[CTAppearance instance].fontName size:15]}];
    [vehicleName appendAttributedString:name];
    [vehicleName appendAttributedString:orSimilar];
    
    self.vehicleNameLabel.attributedText = vehicleName;
    
    self.passengerQtyLabel.text = [NSString stringWithFormat:@"%d %@", item.vehicle.passengerQty.intValue, NSLocalizedString(@"passengers", @"passengers")];
    self.transmissionLabel.text = item.vehicle.transmissionType;
    self.fuelPolicyLabel.text = [self fuelPolicyString: item.vehicle.fuelPolicy];
    
    self.pickupLabel.text = [LocalisedStrings pickupType:item];

    self.totalPriceLabel.text = [item.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    self.totalPriceLabel.textColor = [CTAppearance instance].vehicleCellTint;
    
    if (item.vendor.rating.overallScore != nil) {
        
        NSString *score = [NSString stringWithFormat:@"%.1f", item.vendor.rating.overallScore.floatValue * 2];
        
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
        //self.ratingTitle.text = NSLocalizedString(@"Rating", @"Rating");

       // self.ratingLabel.attributedText = ratingString;
        
    } else {
        //self.ratingTitle.text = @"";
       //self.ratingLabel.text = @"";
    }

    [[CTImageCache sharedInstance] cachedImage: item.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: item.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
}

- (NSString *)fuelPolicyString:(FuelPolicy)fuelPolicy
{
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

    if (fuelPolicy == FuelPolicyChaufFullFull) {
        return NSLocalizedString(@"Full to full chauf", @"Full to full chauf");
    }

    return @"Unknown";
}

@end
