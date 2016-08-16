//
// copyright 2014 Etrawler
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a strong of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
//
//  Booking.h
//  CarTrawler
//

#import <Foundation/Foundation.h>
#import "CTFee.h"
#import "CTCustomer.h"

/**
 *  CTBooking
 */
@interface CTBooking : NSObject

/**
 *  Returns bool value if vehicle has air con or not
 */
@property (nonatomic, readonly) BOOL vehIsAirConditioned;
/**
 *  Returns bool value if vehicle is at airport or not
 */
@property (nonatomic, readonly) BOOL isAtAirport;
/**
 *  The pickup date & time
 */
@property (nonatomic, strong, readonly) NSDate *puDateTime;
/**
 *  The drop off date & time
 */
@property (nonatomic, strong, readonly) NSDate *doDateTime;
/**
 *  The url for the vendor logo
 */
@property (nonatomic, strong, readonly) NSURL *vendorImageUrl;
/**
 *  The vendor booking reference
 */
@property (nonatomic, strong, readonly) NSString *vendorBookingRef;
/**
 *  The customers emil
 */
@property (nonatomic, strong, readonly) NSString *customerEmail;
/**
 *  The customers name title
 */
@property (nonatomic, strong, readonly) NSString *customerTitle;
/**
 *  The customers first name
 */
@property (nonatomic, strong, readonly) NSString *customerGivenName;
/**
 *  The customers surname
 */
@property (nonatomic, strong, readonly) NSString *customerSurname;
/**
 *  The booking confirmation type
 */
@property (nonatomic, strong, readonly) NSString *confType;
/**
 *  the booking confirmation ID
 */
@property (nonatomic, strong, readonly) NSString *confID;
/**
 *  The name of the vendor
 */
@property (nonatomic, strong, readonly) NSString *vendorName;
/**
 *  The vendors ID code
 */
@property (nonatomic, strong, readonly) NSString *vendorCode;
/**
 *  The pickup location code
 */
@property (nonatomic, strong, readonly) NSString *puLocationCode;
/**
 *  The drop off location code
 */
@property (nonatomic, strong, readonly) NSString *doLocationCode;
/**
 *  The pickup location name
 */
@property (nonatomic, strong, readonly) NSString *puLocationName;
/**
 *  The drop off location name
 */
@property (nonatomic, strong, readonly) NSString *doLocationName;
/**
 *  The vehicle transmisson type in string value
 */
@property (nonatomic, strong, readonly) NSString *vehTransmissionType;
/**
 *  The vehicle fuel type in string value
 */
@property (nonatomic, strong, readonly) NSString *vehFuelType;
/**
 *  The amount of passengers the vehicle can hold
 */
@property (nonatomic, strong, readonly) NSString *vehPassengerQty;
/**
 *  The amount of baggage the vehicle can hold
 */
@property (nonatomic, strong, readonly) NSString *vehBaggageQty;
/**
 *  The vehicles ID code
 */
@property (nonatomic, strong, readonly) NSString *vehCode;
/**
 *  The category of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *vehCategory;
/**
 *  the vehicles door count
 */
@property (nonatomic, strong, readonly) NSString *vehDoorCount;
/**
 *  The size of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *vehClassSize;
/**
 *  The make / model name of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *vehMakeModelName;
/**
 *  The make / model code of the vehicle
 */
@property (nonatomic, strong, readonly) NSString *vehMakeModelCode;
/**
 *  Image url for the vehicle
 */
@property (nonatomic, strong, readonly) NSURL *vehPictureUrl;
/**
 *  The vehicles asset number
 */
@property (nonatomic, strong, readonly) NSString *vehAssetNumber;
/**
 *  The total charge for the booking
 */
@property (nonatomic, strong, readonly) NSString *totalChargeAmount;
/**
 *  The estimated charge for the booking
 */
@property (nonatomic, strong, readonly) NSString *estimatedTotalAmount;
/**
 *  The currency code of the booking
 */
@property (nonatomic, strong, readonly) NSString *currencyCode;
/**
 *  the TPA fee amount
 */
@property (nonatomic, strong, readonly) NSString *tpaFeeAmount;
/**
 *  TPA fee currency code
 */
@property (nonatomic, strong, readonly) NSString *tpaFeeCurrencyCode;
/**
 *  TPA fee purpose
 */
@property (nonatomic, strong, readonly) NSString *tpaFeePurpose;
/**
 *  TPA confirmation type
 */
@property (nonatomic, strong, readonly) NSString *tpaConfType;
/**
 *  TPA confirmation ID
 */
@property (nonatomic, strong, readonly) NSString *tpaConfID;
/**
 *  Payment rule type
 */
@property (nonatomic, strong, readonly) NSString *paymentRuleType;
/**
 *  Payment amount
 */
@property (nonatomic, strong, readonly) NSString *paymentAmount;
/**
 *  Payment currency code
 */
@property (nonatomic, strong, readonly) NSString *paymentCurrencyCode;
/**
 *  Rental payment transaction code
 */
@property (nonatomic, strong, readonly) NSString *rentalPaymentTransactionCode;
/**
 *  Rental payment card type
 */
@property (nonatomic, strong, readonly) NSString *rentalPaymentCardType;
/**
 *  Location code
 */
@property (nonatomic, strong, readonly) NSString *locationCode;
/**
 *  Location name
 */
@property (nonatomic, strong, readonly) NSString *locationName;
/**
 *  Location address
 */
@property (nonatomic, strong, readonly) NSString *locationAddress;
/**
 *  Location country name
 */
@property (nonatomic, strong, readonly) NSString *locationCountryName;
/**
 *  Location latitude
 */
@property (nonatomic, strong, readonly) NSString *locationLatitude;
/**
 *  Location longitude
 */
@property (nonatomic, strong, readonly) NSString *locationLongitude;
/**
 *  CTFee array
 */
@property (nonatomic, strong, readonly) NSArray<CTFee *> *fees;
/**
 *  Pickup location phone numbers
 */
@property (nonatomic, strong, readonly) NSArray<NSString *> *locationPhoneNumbers;

#pragma mark Vars below are only available when using Retrieve Booking
/**
 *  Bookng status
 */
@property (nonatomic, strong, readonly) NSString *status;
/**
 *  Booking cancelation policy
 */
@property (nonatomic, strong, readonly) NSString *cancelationPolicy;

/**
 *  Convenience method to set the customer email
 *
 *  @param customerEmail The customers email
 */
- (void)setCustomerEmail:(NSString *)customerEmail;


- (instancetype)initFromRetrievedBookingDictionary:(NSDictionary *)vehReservationDictionary  ;
- (instancetype)initFromVehReservationDictionary:(NSDictionary *)vehReservationDictionary  ;

@end
