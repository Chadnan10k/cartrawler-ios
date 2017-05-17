//
//  CTInPathPayment.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInPathPayment.h"
#import "CartrawlerSDK/CTSDKSettings.h"
#import "CartrawlerSDK/CartrawlerSDK+NSDateUtils.h"
#import "CartrawlerSDK/CTPaymentRequestGenerator.h"
#import "CTInPathVehicle.h"

@implementation CTInPathPayment

+ (NSDictionary *)createInPathRequest:(CTRentalSearch *)search
{
    
    NSString *json = [CTPaymentRequestGenerator OTA_VehResRQ:[search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                                returnDateTime:[search.dropoffDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
                            pickupLocationCode:search.pickupLocation.code
                           dropoffLocationCode:search.dropoffLocation.code
                                   homeCountry:[CTSDKSettings instance].homeCountryCode
                                     driverAge:search.driverAge.stringValue
                                 numPassengers:search.passengerQty.stringValue
                                  flightNumber:search.flightNumber
                                         refID:search.selectedVehicle.vehicle.refID
                                  refTimeStamp:search.selectedVehicle.vehicle.refTimeStamp
                                        refURL:search.selectedVehicle.vehicle.refURL
                                   extrasArray:search.selectedVehicle.vehicle.extraEquipment
                                     givenName:search.firstName
                                       surName:search.surname
                                  emailAddress:search.email
                                       address:search.concatinatedAddress
                                   phoneNumber:search.phone
                               insuranceObject:search.insurance
                             isBuyingInsurance:search.isBuyingInsurance
                                      clientID:[CTSDKSettings instance].clientId
                                        target:[CTSDKSettings instance].target
                                        locale:[CTSDKSettings instance].languageCode
                                      currency:[CTSDKSettings instance].currencyCode];
    
    return @{@"ota" : json,
             @"amt" : [self calculatePayNowPrice:search.selectedVehicle.vehicle
                                       insurance:search.insurance
                                     isBuyingIns:search.isBuyingInsurance],
             @"description" : @""};
}

+ (NSString *)vehicleDescription:(CTVehicle *)vehicle insurance:(CTInsurance *)insurance isBuyingIns:(BOOL)isBuyingIns
{
    
    NSNumber *vehicleAmount = vehicle.totalPriceForThisVehicle;
    NSNumber *insuranceAmount = @0;

    double amt = vehicle.totalPriceForThisVehicle.doubleValue;
    
    if (isBuyingIns) {
        amt += insurance.premiumAmount.doubleValue;
        insuranceAmount = insurance.premiumAmount;
    }
    
    NSNumber *totalAmount = [NSNumber numberWithDouble:amt];
    
    NSNumber *depositAmount = @0;
    NSNumber *payAtDeskAmount = @0;
    NSNumber *bookingFeeAmount = @0;

    for (CTFee *fee in vehicle.fees) {
        if (fee.feePurpose == CTFeeTypePayNow) {
            depositAmount = fee.feeAmount;
        } else if (fee.feePurpose == CTFeeTypePayAtDesk) {
            payAtDeskAmount = fee.feeAmount;
        } else if (fee.feePurpose == CTFeeTypeBooking) {
            bookingFeeAmount = fee.feeAmount;
        }
    }
    
    NSNumber *payNowAmount = [NSNumber numberWithDouble:depositAmount.doubleValue + insuranceAmount.doubleValue + bookingFeeAmount.doubleValue];
    
    NSString *insuranceDesc = [NSString stringWithFormat:
    @"\r  \"insurance\":{ \r"
    @"      \"name\":\"%@\", \r"
    @"      \"amount\":%@, \r"
    @"      \"currency\":\"%@\" \r"
    @"  },", @"Damage Refund Insurance", insurance.premiumAmount.stringValue, insurance.costCurrencyCode];
    
    NSString *depositEnabled = depositAmount.doubleValue > 0.0 ? @"true" : @"false";
    
    NSString *desc = [NSString stringWithFormat:
    @"{\r"
    @"  \"amount\":%@, \r"
    @"  \"totalAmount\":%@, \r"
    @"  \"payNowAmount\":%@, \r"
    @"  \"payAtDeskAmount\":%@, \r"
    @"  \"depositAmount\":%@, \r"
    @"  \"depositRemainderAmount\":%@,"
    @"  %@                    "
    @" \r \"deposit\":%@ \r"
    @"}",
                      vehicleAmount.stringValue,
                      totalAmount.stringValue,
                      payNowAmount.stringValue,
                      payAtDeskAmount.stringValue,
                      payNowAmount.stringValue,
                      payAtDeskAmount.stringValue,
                      (isBuyingIns ? insuranceDesc : @""),
                      depositEnabled];

    return desc;
}

+ (NSNumber *)calculatePayNowPrice:(CTVehicle *)vehicle insurance:(CTInsurance *)insurance isBuyingIns:(BOOL)isBuyingIns
{
    
    NSNumber *insuranceAmount = @0;

    if (isBuyingIns) {
        insuranceAmount = insurance.premiumAmount;
    }
    
    NSNumber *depositAmount = @0;
    
    for (CTFee *fee in vehicle.fees) {
        if (fee.feePurpose == CTFeeTypePayNow) {
            depositAmount = fee.feeAmount;
        }
    }
    
    NSNumber *payNowAmount = [NSNumber numberWithDouble:depositAmount.doubleValue + insuranceAmount.doubleValue];

    return payNowAmount;
}

@end
