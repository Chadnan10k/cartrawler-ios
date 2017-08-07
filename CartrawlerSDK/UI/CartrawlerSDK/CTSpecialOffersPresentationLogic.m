//
//  CTSpecialOffersPresentationLogic.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSpecialOffersPresentationLogic.h"

@implementation CTSpecialOffersPresentationLogic

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
