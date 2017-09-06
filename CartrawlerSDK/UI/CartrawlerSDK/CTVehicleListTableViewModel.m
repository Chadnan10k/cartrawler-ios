//
//  CTVehicleListTableViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTVehicleListTableViewModel.h"
#import "CartrawlerSDK/CartrawlerSDK+NSString.h"
#import "CartrawlerSDK/CartrawlerSDK+NSNumber.h"
#import "CTSpecialOffersPresentationLogic.h"

@interface CTVehicleListTableViewModel ()
@property (nonatomic, readwrite) NSAttributedString *vehicleName;
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
@property (nonatomic, readwrite) NSURL *vendorURL;
@property (nonatomic, readwrite) NSAttributedString *vendorRating;
@property (nonatomic, readwrite) NSAttributedString *price;
@property (nonatomic, readwrite) NSString *perDay;
@property (nonatomic, readwrite) BOOL expandedCell;
@property (nonatomic, readwrite) CTAvailabilityItem *availabilityItem;
@end

@implementation CTVehicleListTableViewModel

+ (instancetype)viewModelForAvailabilityItem:(CTAvailabilityItem *)availabilityItem
                                  pickupDate:(NSDate *)pickupDate
                                 dropoffDate:(NSDate *)dropoffDate {
    CTVehicleListTableViewModel *viewModel = [CTVehicleListTableViewModel new];
    CTVehicle *vehicle = availabilityItem.vehicle;
    
    viewModel.vehicleName = [NSString attributedText:vehicle.makeModelName boldColor:[UIColor blackColor] boldSize:16 regularText:availabilityItem.vehicle.orSimilar regularColor:[UIColor lightGrayColor] regularSize:12 useSpace:YES];
    
    viewModel.passengers = [NSString stringWithFormat:@"%@ %@", vehicle.passengerQty.stringValue, CTLocalizedString(CTRentalVehiclePassengers)];
    
    viewModel.bags = [NSString stringWithFormat:@"%@ %@", vehicle.baggageQty.stringValue, CTLocalizedString(CTRentalVehicleBags)];
    
    // TODO: Remove this logic from CTLocalisedStrings
    viewModel.fuel = [CTLocalisedStrings fuelPolicy:vehicle.fuelPolicy];
    viewModel.location = [CTLocalisedStrings pickupType:availabilityItem];
    
    viewModel.vehicleURL = vehicle.pictureURL;
    
    viewModel.vendorRating = [NSString attributedText:[@(availabilityItem.vendor.rating.overallScore.doubleValue * 2) decimalPlaces:1]
                                                    boldColor:[UIColor blackColor]
                                                     boldSize:18
                                                  regularText:@"/10"
                                                 regularColor:[UIColor lightGrayColor]
                                                  regularSize:14
                                                     useSpace:NO];
    
    NSString *totalPrice = [availabilityItem.vehicle.totalPriceForThisVehicle pricePerDay:pickupDate dropoff:dropoffDate];
    viewModel.price = [NSString attributedText:totalPrice
                                     boldColor:[UIColor blackColor]
                                      boldSize:21
                                   regularText:@""
                                  regularColor:[UIColor lightGrayColor]
                                   regularSize:17
                                      useSpace:NO];
    
    viewModel.perDay = CTLocalizedString(CTRentalExtrasPerDay);
    
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
    
    viewModel.vendorURL = availabilityItem.vendor.logoURL;
    viewModel.availabilityItem = availabilityItem;
    
    return viewModel;
}

@end
