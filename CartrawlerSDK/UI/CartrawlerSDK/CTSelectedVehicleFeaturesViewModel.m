//
//  CTSelectedVehicleFeaturesViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 22/08/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleFeaturesViewModel.h"
#import "CTAppController.h"

@implementation CTSelectedVehicleFeaturesViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTAlertAction *action = [CTAlertAction actionWithTitle:@"OK" handler:^(CTAlertAction *action) {
        [CTAppController dispatchAction:CTActionSelectedVehicleUserDidDismissMoreFeatures payload:nil];
    }];
    
    return [[CTSelectedVehicleFeaturesViewModel alloc] initWithTitle:@"More Features"
                                                             message:[self moreFeaturesText:selectedVehicleState.selectedAvailabilityItem.vehicle]
                                                              action:action];
}

+ (NSAttributedString *)moreFeaturesText:(CTVehicle *)vehicle {
    NSMutableAttributedString *moreFeatures = [[NSMutableAttributedString alloc] initWithString:@"\n"];
    
    if (vehicle.isUSBEnabled) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureUSB) icon:@""]];
    }
    
    if (vehicle.isBluetoothEnabled) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureBluetooth) icon:@""]];
    }
    
    if (vehicle.isAirConditioned) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalVehicleAirConditioning) icon:@""]];
    }
    
    if (vehicle.isGPSIncluded) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureGPS) icon:@""]];
    }
    
    if (vehicle.isGermanModel) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureGermanModel) icon:@""]];
    }
    
    if (vehicle.isParkingSensorEnabled) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureParkingSensors) icon:@""]];
    }
    
    if (vehicle.isExceptionalFuelEconomy) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureFuelEconomy) icon:@""]];
    }
    
    if (vehicle.isFrontDemisterEnabled) {
        [moreFeatures appendAttributedString:[self attributedString:CTLocalizedString(CTRentalFeatureFrontDemister) icon:@""]];
    }
    
    [moreFeatures appendAttributedString:[self attributedString:vehicle.transmissionType icon:@""]];
    
    return moreFeatures;
}

+ (NSAttributedString *)attributedString:(NSString *)text icon:(NSString *)icon {
    // This is a hack to left align the text and right align the icon
    // The alternative is creating a whole new view which I don't think is worth it
    NSString *string = [text stringByAppendingString:@"\t"];
    string = [string stringByAppendingString:icon];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.alignment = NSTextAlignmentLeft;
    
    
    CGFloat margin = 16;
    CGFloat numberOfMargins = 4;
    CGFloat tabLocation = [UIScreen mainScreen].bounds.size.width - (numberOfMargins * margin);
    NSTextTab *t = [[NSTextTab alloc] initWithTextAlignment:NSTextAlignmentRight location:tabLocation options:@{}];
    paragraph.tabStops = @[t];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(0, string.length-1)];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"V5-Mobile" size:16.0] range:NSMakeRange(string.length-1, 1)];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, string.length)];
    
    [attributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
    
    return attributedString.copy;
}

@end
