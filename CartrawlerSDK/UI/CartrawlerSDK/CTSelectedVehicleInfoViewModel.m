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
@property (nonatomic, readwrite) NSString *fuel;
@property (nonatomic, readwrite) NSString *location;
@property (nonatomic, readwrite) NSURL *vehicleURL;
@property (nonatomic, readwrite) BOOL displayMerchandising;
@property (nonatomic, readwrite) NSString *merchandisingText;
@property (nonatomic, readwrite) UIColor *merchandisingColor;
@property (nonatomic, readwrite) BOOL displaySpecialOffer;
@property (nonatomic, readwrite) NSString *specialOffer;
@property (nonatomic, readwrite) UIColor *specialOfferColor;
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
    
    // TODO: Remove this logic from CTLocalisedStrings
    viewModel.fuel = [CTLocalisedStrings fuelPolicy:vehicle.fuelPolicy];
    viewModel.location = [CTLocalisedStrings pickupType:availabilityItem];
    
    viewModel.vehicleURL = vehicle.pictureURL;
        
    if (vehicle.merchandisingTag != CTMerchandisingTagUnknown) {
        viewModel.displayMerchandising = YES;
        // TODO: Add star
        viewModel.merchandisingText = [CTSpecialOffersPresentationLogic merchandisingText:vehicle.merchandisingTag];
        viewModel.merchandisingColor = [CTSpecialOffersPresentationLogic merchandisingColor:vehicle.merchandisingTag];
    }
    
    viewModel.specialOffer = [CTSpecialOffersPresentationLogic specialOfferText:vehicle.specialOffers];
    if (viewModel.specialOffer) {
        // TODO: Add bolt
        viewModel.displaySpecialOffer = YES;
        viewModel.specialOfferColor = [UIColor colorWithRed:207.0/255.0 green:46.0/255.0 blue:29.0/255.0 alpha:1];
    }
    
    
    return viewModel;
}

@end
