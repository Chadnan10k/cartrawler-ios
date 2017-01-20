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
#import "CartrawlerSDK/CTPaymentRequest.h"
#import "CTInPathVehicle.h"

@implementation CTInPathPayment

+ (NSDictionary *)createInPathRequest:(CTRentalSearch *)search
{
    
    NSString *json = [CTPaymentRequest OTA_VehResRQ:[search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
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
    

    NSNumber *amount = search.selectedVehicle.vehicle.totalPriceForThisVehicle;
    
    NSString *vehDescription = @"";
    
    return @{@"ota" : json,
             @"amt" : amount.stringValue,
             @"description" : vehDescription};
}

@end
