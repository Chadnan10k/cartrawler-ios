//
//  CTPaymentSummaryViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 15/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryViewModel.h"
#import "CartrawlerSDK+NSNumber.h"

@interface CTPaymentSummaryViewModel ()
@property (nonatomic, readwrite) NSArray <CTPaymentSummaryCellModel *> *payAtDeskRowViewModels;
@property (nonatomic, readwrite) NSArray <CTPaymentSummaryCellModel *> *payNowRowViewModels;
@property (nonatomic, readwrite) NSString *total;
@end

@implementation CTPaymentSummaryViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTPaymentSummaryViewModel *viewModel = [CTPaymentSummaryViewModel new];
    CTSelectedVehicleState *selectedVehicleState = appState.selectedVehicleState;
    viewModel.payAtDeskRowViewModels = [self payAtDeskCharges:selectedVehicleState.selectedAvailabilityItem.vehicle addedExtras:selectedVehicleState.addedExtras];
    CTInsurance *insurance = appState.selectedVehicleState.insuranceAdded ? appState.selectedVehicleState.insurance : nil;
    viewModel.payNowRowViewModels = [self payNowCharges:selectedVehicleState.selectedAvailabilityItem.vehicle insurance:insurance];
    viewModel.total = [self totalPrice:appState];
    return viewModel;
}

+ (NSString *)totalPrice:(CTAppState *)appState {
    if (appState.selectedVehicleState.insuranceAdded) {
        return [[NSNumber numberWithFloat:appState.selectedVehicleState.selectedAvailabilityItem.vehicle.totalPriceForThisVehicle.floatValue + appState.selectedVehicleState.insurance.premiumAmount.floatValue] numberStringWithCurrencyCode];
    } else {
        return [appState.selectedVehicleState.selectedAvailabilityItem.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    }
}

+ (NSArray *)payNowCharges:(CTVehicle *)vehicle insurance:(CTInsurance *)insurance {
    NSMutableArray *charges = [NSMutableArray new];
    
    for (CTFee *fee in vehicle.fees) {
        if ((fee.feePurpose == CTFeeTypePayNow || fee.feePurpose == CTFeeTypeBooking) && fee.feeAmount.integerValue > 0) {
            NSString *title = [self titleForFee:fee];
            NSString *detail = [fee.feeAmount numberStringWithCurrencyCode];
            CTPaymentSummaryCellModel *cellModel = [[CTPaymentSummaryCellModel alloc] initWithTitle:title detail:detail];
            [charges addObject:cellModel];
        }
    }
    
    if (insurance) {
        NSString *title = CTLocalizedString(CTRentalSummaryDamageRefund);
        NSString *detail = [insurance.costAmount numberStringWithCurrencyCode];
        CTPaymentSummaryCellModel *cellModel = [[CTPaymentSummaryCellModel alloc] initWithTitle:title detail:detail];
        [charges addObject:cellModel];
    }
    
    return charges.copy;
}

+ (NSArray *)payAtDeskCharges:(CTVehicle *)vehicle addedExtras:(NSArray *)addedExtras {
    NSMutableArray *charges = [NSMutableArray new];
    
    for (CTFee *fee in vehicle.fees) {
        if (fee.feePurpose == CTFeeTypePayAtDesk && fee.feeAmount.integerValue > 0) {
            NSString *title = [self titleForFee:fee];
            NSString *detail = [fee.feeAmount numberStringWithCurrencyCode];
            CTPaymentSummaryCellModel *cellModel = [[CTPaymentSummaryCellModel alloc] initWithTitle:title detail:detail];
            [charges addObject:cellModel];
        }
    }
    
    for (CTExtraEquipment *extra in vehicle.extraEquipment) {
        if (extra.isIncludedInRate || extra.qty > 0) {
            [charges addObject:extra];
            NSString *title = [self titleForExtra:extra];
            NSString *detail = [self detailForExtra:extra];
            CTPaymentSummaryCellModel *cellModel = [[CTPaymentSummaryCellModel alloc] initWithTitle:title detail:detail];
            [charges addObject:cellModel];
        }
    }
    
    if (charges.count == 0) {
        CTPaymentSummaryCellModel *cellModel = [[CTPaymentSummaryCellModel alloc] initWithTitle:CTLocalizedString(CTRentalPayNothingAtDesk) detail:@""];
        [charges addObject:cellModel];
    }
    
    return charges.copy;
}

+ (NSString *)titleForFee:(CTFee *)fee {
    switch (fee.feePurpose) {
        case CTFeeTypePayNow:
            return CTLocalizedString(CTRentalSummaryPayNow);
            break;
        case CTFeeTypePayAtDesk:
            return CTLocalizedString(CTRentalSummaryPayAtDesk);
            break;
        case CTFeeTypeBooking:
            return CTLocalizedString(CTRentalSummaryBookingFee);
            break;
        default:
            break;
    }
    return @"";
}


+ (NSString *)titleForExtra:(CTExtraEquipment *)extra {
    NSString *title = extra.equipDescription;
    if (extra.qty > 1) {
        NSString *quantity = [NSString stringWithFormat:@" (x%ld)", (long)extra.qty];
        title = [title stringByAppendingString:quantity];
    }
    return title;
}

+ (NSString *)detailForExtra:(CTExtraEquipment *)extra {
    if (extra.isIncludedInRate) {
        return CTLocalizedString(CTRentalPaymentFree);
    }
    double charge = extra.chargeAmount.doubleValue * extra.qty;
    return [@(charge) numberStringWithCurrencyCode];
}

@end
