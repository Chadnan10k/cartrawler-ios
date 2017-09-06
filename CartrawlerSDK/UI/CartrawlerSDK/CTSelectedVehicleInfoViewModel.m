//
//  CTSelectedVehicleInfoViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleInfoViewModel.h"
#import "CTAppState.h"
#import "CTSpecialOffersPresentationLogic.h"

@interface CTSelectedVehicleInfoViewModel ()
@property (nonatomic, readwrite) NSString *vehicleName;
@property (nonatomic, readwrite) NSString *passengers;
@property (nonatomic, readwrite) NSString *bags;
@property (nonatomic, readwrite) NSString *doors;
@property (nonatomic, readwrite) NSString *featuresCount;
@property (nonatomic, readwrite) NSString *features;
@property (nonatomic, readwrite) NSString *location;
@property (nonatomic, readwrite) NSURL *vehicleURL;
@property (nonatomic, readwrite) UIColor *primaryColor;
@property (nonatomic, readwrite) NSAttributedString *freeCancellation;
@property (nonatomic, readwrite) BOOL displayMerchandising;
@property (nonatomic, readwrite) NSString *merchandisingText;
@property (nonatomic, readwrite) UIColor *merchandisingColor;
@property (nonatomic, readwrite) BOOL expandedCell;
@end

@implementation CTSelectedVehicleInfoViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSelectedVehicleInfoViewModel *viewModel = [CTSelectedVehicleInfoViewModel new];
    
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    CTAvailabilityItem *availabilityItem = selectedVehicleState.selectedAvailabilityItem;
    CTVehicle *vehicle = availabilityItem.vehicle;
    
    viewModel.vehicleName = vehicle.makeModelName;
    
    viewModel.passengers = [NSString stringWithFormat:@"%@ %@", vehicle.passengerQty.stringValue, CTLocalizedString(CTRentalVehiclePassengers)];
    
    viewModel.bags = [NSString stringWithFormat:@"%@ %@", vehicle.baggageQty.stringValue, CTLocalizedString(CTRentalVehicleBags)];
    viewModel.features = CTLocalizedString(CTRentalMore);
    viewModel.featuresCount = [NSString stringWithFormat:@"+%ld", (long)[self featuresCount:vehicle]];
    
    // TODO: Remove this logic from CTLocalisedStrings
    viewModel.doors = [NSString stringWithFormat:@"%@ %@", vehicle.doorCount.stringValue, CTLocalizedString(CTRentalVehicleDoors)];
    viewModel.location = [CTLocalisedStrings pickupType:availabilityItem];
    
    viewModel.vehicleURL = vehicle.pictureURL;
    
    viewModel.primaryColor = appState.userSettingsState.primaryColor;
    
    NSMutableAttributedString *freeCancellation = [self tickString].mutableCopy;
    [freeCancellation appendAttributedString:[self freeString]];
    [freeCancellation appendAttributedString:[self cancellationString]];
    viewModel.freeCancellation = freeCancellation.copy;
        
    if (vehicle.merchandisingTag != CTMerchandisingTagUnknown) {
        viewModel.displayMerchandising = YES;
        // TODO: Add star
        viewModel.merchandisingText = [CTSpecialOffersPresentationLogic merchandisingText:vehicle.merchandisingTag];
        viewModel.merchandisingColor = [CTSpecialOffersPresentationLogic merchandisingColor:vehicle.merchandisingTag];
    }
    
    return viewModel;
}

+ (NSInteger)featuresCount:(CTVehicle *)vehicle {
    // TODO: Extract to array of features for re-use in features view
    return vehicle.isUSBEnabled + vehicle.isBluetoothEnabled + vehicle.isAirConditioned + vehicle.isGPSIncluded + vehicle.isGermanModel + vehicle.isParkingSensorEnabled + vehicle.isExceptionalFuelEconomy + vehicle.isFrontDemisterEnabled + 1;
}

+ (NSAttributedString *)tickString {
    NSMutableAttributedString *tickString = [[NSMutableAttributedString alloc] initWithString:@"  "];
    [tickString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"V5-Mobile" size:14] range:NSMakeRange(0, tickString.length)];
    [tickString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, tickString.length)];
    return tickString.copy;
}

+ (NSAttributedString *)freeString {
    NSMutableAttributedString *freeString = [[NSMutableAttributedString alloc] initWithString:@"Free"];
    [freeString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14.0] range:NSMakeRange(0, freeString.length)];
    [freeString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, freeString.length)];
    return freeString.copy;
}

+ (NSAttributedString *)cancellationString {
    NSMutableAttributedString *cancellationString = [[NSMutableAttributedString alloc] initWithString:@" cancellation and amendments"];
    [cancellationString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14.0] range:NSMakeRange(0, cancellationString.length)];
    [cancellationString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, cancellationString.length)];
    return cancellationString.copy;
}

@end
