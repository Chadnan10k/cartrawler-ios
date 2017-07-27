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
#import "CTLocalisedStrings.h"
#import "CTSDKLocalizationConstants.h"

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
    
    if (vehicle.merchandisingTag != CTMerchandisingTagUnknown) {
        viewModel.displayMerchandising = YES;
        // TODO: Add star
        viewModel.merchandisingText = [self merchandisingText:vehicle.merchandisingTag];
        viewModel.merchandisingColor = [self merchandisingColor:vehicle.merchandisingTag];
    }
    
    viewModel.specialOffer = [self specialOfferText:vehicle.specialOffers];
    if (viewModel.specialOffer) {
        // TODO: Add bolt
        viewModel.displaySpecialOffer = YES;
        viewModel.specialOfferColor = [UIColor colorWithRed:207.0/255.0 green:46.0/255.0 blue:29.0/255.0 alpha:1];
    }
    
    viewModel.vendorURL = availabilityItem.vendor.logoURL;
    viewModel.availabilityItem = availabilityItem;
    
    return viewModel;
}

+ (NSString *)specialOfferText:(NSArray <CTSpecialOffer *> *)specialOffers {
    CTSpecialOffer *chosenOffer;
    BOOL priorityOfferFound = NO;
    
    for (CTSpecialOffer *specialOffer in specialOffers) {
        switch (specialOffer.type) {
            case CTSpecialOfferTypeCartrawlerCash:
            case CTSpecialOfferTypePercentageDiscount:
            case CTSpecialOfferTypePercentageDiscountBranded:
            case CTSpecialOfferTypeGenericDiscount:
            case CTSpecialOfferTypeGenericDiscountBranded:
                chosenOffer = specialOffer;
                priorityOfferFound = YES;
                break;
            default:
                break;
        }
    }
    
    return priorityOfferFound ? chosenOffer.shortText : nil;
}

+ (NSString *)merchandisingText:(CTMerchandisingTag)merchandisingTag
{
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            return CTLocalizedString(CTRentalVehicleMerchandisingBusiness);
            
        case CTMerchandisingTagCityBreak:
            return CTLocalizedString(CTRentalVehicleMerchandisingCityBreak);
            
        case CTMerchandisingTagFamilySize:
            return CTLocalizedString(CTRentalVehicleMerchandisingFamilySize);
            
        case CTMerchandisingTagBestSeller:
            return CTLocalizedString(CTRentalVehicleMerchandisingBestSeller);
            
        case CTMerchandisingTagGreatValue:
            return CTLocalizedString(CTRentalVehicleMerchandisingGreatValue);
            break;
            
        case CTMerchandisingTagQuickestQueue:
            return CTLocalizedString(CTRentalVehicleMerchandisingQuickestQueue);
            break;
            
        case CTMerchandisingTagRecommended:
            return CTLocalizedString(CTRentalVehicleMerchandisingRecommended);
            break;
            
        case CTMerchandisingTagUpgradeTo:
            return CTLocalizedString(CTRentalVehicleMerchandisingUpgradeTo);
            break;
            
        case CTMerchandisingTagOnBudget:
            return CTLocalizedString(CTRentalVehicleMerchandisingOnBudget);
            break;
            
        case CTMerchandisingTagBestReviewed:
            return CTLocalizedString(CTRentalVehicleMerchandisingBestReviewed);
            break;
            
        case CTMerchandisingTagUnknown:
            return @"";
            break;
    }
}

+ (UIColor *)merchandisingColor:(CTMerchandisingTag)merchandisingTag
{
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            return [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
            
        case CTMerchandisingTagCityBreak:
            return [UIColor colorWithRed:4.0/255.0 green:119.0/255.0 blue:188.0/255.0 alpha:1];
            
        case CTMerchandisingTagFamilySize:
            return [UIColor colorWithRed:189.0/255.0 green:15.0/255.0 blue:134.0/255.0 alpha:1];
            
        case CTMerchandisingTagBestSeller:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagGreatValue:
            return [UIColor colorWithRed:41.0/255.0 green:173.0/255.0 blue:79.0/255.0 alpha:1];
            
        case CTMerchandisingTagQuickestQueue:
            return [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:0.0/255.0 alpha:1];
            
        case CTMerchandisingTagRecommended:
            return [UIColor colorWithRed:254.0/255.0 green:67.0/255.0 blue:101.0/255.0 alpha:1];
            
        case CTMerchandisingTagUpgradeTo:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagOnBudget:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagBestReviewed:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            
        case CTMerchandisingTagUnknown:
            return [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
    }
}

@end
