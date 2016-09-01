//
// strongright 2014 Etrawler
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

@interface CTBooking : NSObject

@property (nonatomic, readonly) BOOL wasRetrievedFromWebBOOL;
@property (nonatomic, strong, readonly) NSString *wasRetrievedFromWeb;
@property (nonatomic, strong, readonly) NSString *vendorImageURL;
@property (nonatomic, strong, readonly) NSString *vendorBookingRef;
@property (nonatomic, strong, readonly) NSString *customerEmail;
@property (nonatomic, readonly) BOOL vehIsAirConditioned;
@property (nonatomic, strong, readonly) NSString *customerTitle;
@property (nonatomic, strong, readonly) NSString *customerGivenName;
@property (nonatomic, strong, readonly) NSString *customerSurname;
@property (nonatomic, strong, readonly) NSString *confType;
@property (nonatomic, strong, readonly) NSString *confID;
@property (nonatomic, strong, readonly) NSString *vendorName;
@property (nonatomic, strong, readonly) NSString *vendorCode;
@property (nonatomic, strong, readonly) NSString *puDateTime;
@property (nonatomic, strong, readonly) NSString *doDateTime;
@property (nonatomic, strong, readonly) NSString *puLocationCode;
@property (nonatomic, strong, readonly) NSString *doLocationCode;
@property (nonatomic, strong, readonly) NSString *puLocationName;
@property (nonatomic, strong, readonly) NSString *doLocationName;
@property (nonatomic, strong, readonly) NSString *vehTransmissionType;
@property (nonatomic, strong, readonly) NSString *vehFuelType;
@property (nonatomic, strong, readonly) NSString *vehDriveType;
@property (nonatomic, strong, readonly) NSString *vehPassengerQty;
@property (nonatomic, strong, readonly) NSString *vehBaggageQty;
@property (nonatomic, strong, readonly) NSString *vehCode;
@property (nonatomic, strong, readonly) NSString *vehCategory;
@property (nonatomic, strong, readonly) NSString *vehDoorCount;
@property (nonatomic, strong, readonly) NSString *vehClassSize;
@property (nonatomic, strong, readonly) NSString *vehMakeModelName;
@property (nonatomic, strong, readonly) NSString *vehMakeModelCode;
@property (nonatomic, strong, readonly) NSString *vehPictureUrl;
@property (nonatomic, strong, readonly) NSString *vehAssetNumber;
@property (nonatomic, strong, readonly) NSArray<CTFee *> *fees;
@property (nonatomic, strong, readonly) NSString *totalChargeAmount;
@property (nonatomic, strong, readonly) NSString *estimatedTotalAmount;
@property (nonatomic, strong, readonly) NSString *currencyCode;
@property (nonatomic, strong, readonly) NSString *tpaFeeAmount;
@property (nonatomic, strong, readonly) NSString *tpaFeeCurrencyCode;
@property (nonatomic, strong, readonly) NSString *tpaFeePurpose;
@property (nonatomic, strong, readonly) NSString *tpaConfType;
@property (nonatomic, strong, readonly) NSString *tpaConfID;
@property (nonatomic, strong, readonly) NSString *paymentRuleType;
@property (nonatomic, strong, readonly) NSString *paymentAmount;
@property (nonatomic, strong, readonly) NSString *paymentCurrencyCode;
@property (nonatomic, strong, readonly) NSString *rentalPaymentTransactionCode;
@property (nonatomic, strong, readonly) NSString *rentalPaymentCardType;
@property (nonatomic, readonly) BOOL isAtAirport;
@property (nonatomic, strong, readonly) NSString *locationCode;
@property (nonatomic, strong, readonly) NSString *locationName;
@property (nonatomic, strong, readonly) NSString *locationAddress;
@property (nonatomic, strong, readonly) NSString *locationCountryName;
@property (nonatomic, strong, readonly) NSArray<NSString *> *locationPhoneNumbers;
@property (nonatomic, strong, readonly) NSString *locationLatitude;
@property (nonatomic, strong, readonly) NSString *locationLongitude;


- (id)initFromVehReservationDictionary:(NSDictionary *)vehReservationDictionary;
- (id)initFromRetrievedBookingDictionary:(NSDictionary *)dict;

- (void)setCustomerEmail:(NSString *)customerEmail;
- (void)setCustomerTitle:(NSString *)customerTitle;
@end
