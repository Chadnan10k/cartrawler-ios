//
//  Booking.m
//  CarTrawler
//

#import "CTBooking.h"
#import "ImageResizeURL.h"
#import "Constants.h"

@implementation CTBooking


// setLocationDetails: Takes a dictionary containing a 'light' CTLocation dictionary and adds it's attributes to this object.

- (void)setLocationDetails:(NSDictionary *)dict {
	_isAtAirport        = [dict[@"@AtAirport"] boolValue];
	_locationCode       = dict[@"@Code"];
	_locationName       = dict[@"@Name"];
	_locationAddress    = dict[@"Address"][@"AddressLine"];
	_locationCountryName = dict[@"Address"][@"CountryName"][@"@Code"];
    
    NSString *phoneNums = dict[@"Telephone"][@"@PhoneNumber"];
    if ([phoneNums rangeOfString:@","].location == NSNotFound) {
        _locationPhoneNumbers = [dict[@"Telephone"][@"@PhoneNumber"] componentsSeparatedByString:@"/"];
    } else {
        _locationPhoneNumbers = [dict[@"Telephone"][@"@PhoneNumber"] componentsSeparatedByString:@","];
    }
    
	NSArray *coords = [dict[@"Address"][@"@Remark"] componentsSeparatedByString:@","];
    if (coords[0] != nil && coords[1] != nil) {
        _locationLatitude = coords[0];
        _locationLongitude = coords[1];
    } else {
        _locationLatitude = @"";
        _locationLongitude = @"";
    }
}

- (instancetype)initFromRetrievedBookingDictionary:(NSDictionary *)vehReservationDictionary
{
    self = [super init];
    vehReservationDictionary = vehReservationDictionary[@"VehRetResRSCore"][@"VehReservation"];
    
    _status = vehReservationDictionary[@"@Status"] ?: @"N/A";
    _cancelationPolicy = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"CancellationPolicy"];
    
    _customerGivenName  = vehReservationDictionary[@"Customer"][@"Primary"][@"PersonName"][@"GivenName"];
    _customerSurname    = vehReservationDictionary[@"Customer"][@"Primary"][@"PersonName"][@"Surname"];
    _customerEmail      = vehReservationDictionary[@"Customer"][@"Primary"][@"Email"][@"#text"];
    _vendorName         = vehReservationDictionary[@"VehSegmentCore"][@"Vendor"][@"@CompanyShortName"];
    _vendorCode         = vehReservationDictionary[@"VehSegmentCore"][@"Vendor"][@"@Code"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = CTAvailRequestDateFormat;
    NSString *puDateString = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"@PickUpDateTime"];
    NSString *doDateString = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"@ReturnDateTime"];
    _puDateTime = [dateFormatter dateFromString:puDateString];
    _doDateTime = [dateFormatter dateFromString:doDateString];
    
    _puLocationCode = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"PickUpLocation"][@"@LocationCode"];
    _puLocationName = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"PickUpLocation"][@"@Name"];
    
    _doLocationCode = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"ReturnLocation"][@"@LocationCode"];
    _doLocationName = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"ReturnLocation"][@"@Name"];
    
    // Vehicle
    
    _vehIsAirConditioned    = [vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@AirConditionInd"] boolValue];
    _vehTransmissionType    = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@TransmissionType"];
    _vehFuelType            = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@FuelType"];
    _vehPassengerQty        = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@PassengerQuantity"];
    _vehBaggageQty          = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@BaggageQuantity"];
    _vehCode                = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@Code"];
    _vehCategory            = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehType"][@"@VehicleCategory"];
    _vehDoorCount           = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehType"][@"@DoorCount"];
    _vehClassSize           = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehClass"][@"@Size"];
    _vehMakeModelName       = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehMakeModel"][@"@Name"];
    _vehMakeModelCode       = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehMakeModel"][@"@Code"];
    _vehPictureUrl          = [ImageResizeURL vehicle:vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"PictureURL"]];
    
    if (vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"VendorPictureURL"]) {
        _vendorImageUrl = [ImageResizeURL vendor:vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"VendorPictureURL"]];
    }
    
    _rentalPaymentTransactionCode = vehReservationDictionary[@"VehSegmentInfo"][@"RentalPaymentAmount"][@"@PaymentTransactionTypeCode"];
    _rentalPaymentCardType = vehReservationDictionary[@"VehSegmentInfo"][@"RentalPaymentAmount"][@"PaymentCard"][@"@CardType"];
    
    /* Locations Details
     There are two ways this go down;
     
     1. The pickup point and dropoff point are the same, in which case it gets returned to us as a single dictionary full of attributes.
     2. The pickup and drop off points are different, so we get an array with two different locations back.
     
     We could init these both as CTLocations but I haven't designed this to persist objects so we'll have to be more verbose and deal with individual items.
     Also worth noting here that the alternate drop off point means nothing to the app in terms of UI or receipt, so we don't need to store it at this point BUT
     we do need the pickup details, so, lets test for Dict or Array and then parse the required section of the response.
     
     */
    
    if ([vehReservationDictionary[@"VehSegmentInfo"][@"LocationDetails"] isKindOfClass:[NSArray class]]) {
        [self setLocationDetails:vehReservationDictionary[@"VehSegmentInfo"][@"LocationDetails"][0]];
    } else {
        [self setLocationDetails:vehReservationDictionary[@"VehSegmentInfo"][@"LocationDetails"]];
    }
    
    return self;
}

- (instancetype)initFromVehReservationDictionary:(NSDictionary *)vehReservationDictionary
{
    self = [super init];

    vehReservationDictionary = vehReservationDictionary[@"VehResRSCore"][@"VehReservation"];
    
	_customerGivenName  = vehReservationDictionary[@"Customer"][@"Primary"][@"PersonName"][@"GivenName"];
	_customerSurname    = vehReservationDictionary[@"Customer"][@"Primary"][@"PersonName"][@"Surname"];
	_customerEmail      = vehReservationDictionary[@"Customer"][@"Primary"][@"Email"][@"#text"];
	_confType           = vehReservationDictionary[@"VehSegmentCore"][@"ConfID"][@"@Type"];
	_confID             = vehReservationDictionary[@"VehSegmentCore"][@"ConfID"][@"@ID"];
	_vendorName         = vehReservationDictionary[@"VehSegmentCore"][@"Vendor"][@"@CompanyShortName"];
	_vendorCode         = vehReservationDictionary[@"VehSegmentCore"][@"Vendor"][@"@Code"];
	
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = CTAvailRequestDateFormat;
    NSString *puDateString = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"@PickUpDateTime"];
    NSString *doDateString = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"@ReturnDateTime"];
    _puDateTime = [dateFormatter dateFromString:puDateString];
    _doDateTime = [dateFormatter dateFromString:doDateString];
    
    _puLocationCode = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"PickUpLocation"][@"@LocationCode"];
	_puLocationName = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"PickUpLocation"][@"@Name"];
	
	_doLocationCode = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"ReturnLocation"][@"@LocationCode"];
	_doLocationName = vehReservationDictionary[@"VehSegmentCore"][@"VehRentalCore"][@"ReturnLocation"][@"@Name"];
	
	// Vehicle
	
	_vehIsAirConditioned    = [vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@AirConditionInd"] boolValue];
	_vehTransmissionType    = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@TransmissionType"];
	_vehFuelType            = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@FuelType"];
	_vehPassengerQty        = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@PassengerQuantity"];
	_vehBaggageQty          = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@BaggageQuantity"];
	_vehCode                = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"@Code"];
	_vehCategory            = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehType"][@"@VehicleCategory"];
	_vehDoorCount           = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehType"][@"@DoorCount"];
	_vehClassSize           = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehClass"][@"@Size"];
	_vehMakeModelName       = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehMakeModel"][@"@Name"];
	_vehMakeModelCode       = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehMakeModel"][@"@Code"];
	_vehPictureUrl          = [ImageResizeURL vehicle:vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"PictureURL"] ?: @""];
	_vehAssetNumber         = vehReservationDictionary[@"VehSegmentCore"][@"Vehicle"][@"VehIdentity"][@"@VehicleAssetNumber"];
	
	// Fees
	
	NSMutableArray *tempFees = vehReservationDictionary[@"VehSegmentCore"][@"Fees"];
    NSMutableArray *tempFeesStore = [[NSMutableArray alloc] init];
	for (int i = 0; i < tempFees.count; i++) {
		CTFee *f = [[CTFee alloc] initFromFeeDictionary:tempFees[i]];
		[tempFeesStore addObject:f];
	}
    
    _fees = tempFeesStore;
	// Total Charge
	
	_totalChargeAmount      = vehReservationDictionary[@"VehSegmentCore"][@"TotalCharge"][@"@RateTotalAmount"];
	_estimatedTotalAmount   = vehReservationDictionary[@"VehSegmentCore"][@"TotalCharge"][@"@EstimatedTotalAmount"];
	_currencyCode           = vehReservationDictionary[@"VehSegmentCore"][@"TotalCharge"][@"@CurrencyCode"];
	
	// TPA Extensions
	
	_tpaFeeAmount       = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"Fees"][@"Fee"][@"@Amount"];
	_tpaFeeCurrencyCode = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"Fees"][@"Fee"][@"@CurrencyCode"];
	_tpaFeePurpose      = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"Fees"][@"Fee"][@"@Purpose"];
	
	if ([vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"ConfID"] isKindOfClass:[NSArray class]]) {
		
		NSDictionary *confDict  = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"ConfID"][0];
		_tpaConfType            = confDict[@"@Type"];
		_tpaConfID              = confDict[@"@ID"];
		
		//_tpaConfType = [[[[vehReservationDictionary objectForKey:@"VehSegmentCore"] objectForKey:@"TPA_Extensions"] objectForKey:@"ConfID"] objectForKey:@"@Type"];
		//_tpaConfID = [[[[vehReservationDictionary objectForKey:@"VehSegmentCore"] objectForKey:@"TPA_Extensions"] objectForKey:@"ConfID"] objectForKey:@"@ID"];
		
	} else {
		if (vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"ConfID"]) {
			_tpaConfType = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"ConfID"][@"@Type"];
			_tpaConfID   = vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"ConfID"][@"@ID"];
		}
	}

	_vendorBookingRef = self.tpaConfID;
	
	if (vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"VendorPictureURL"]) {
        _vendorImageUrl = [ImageResizeURL vendor:vehReservationDictionary[@"VehSegmentCore"][@"TPA_Extensions"][@"VendorPictureURL"] ?: @""];
	}
	
	// Payment Rules
	
	_paymentRuleType = vehReservationDictionary[@"VehSegmentInfo"][@"PaymentRules"][@"PaymentRule"][@"@RuleType"];
	_paymentAmount   = vehReservationDictionary[@"VehSegmentInfo"][@"PaymentRules"][@"PaymentRule"][@"@Amount"];
	_paymentCurrencyCode = vehReservationDictionary[@"VehSegmentInfo"][@"PaymentRules"][@"PaymentRule"][@"@CurrencyCode"];
	
	_rentalPaymentTransactionCode = vehReservationDictionary[@"VehSegmentInfo"][@"RentalPaymentAmount"][@"@PaymentTransactionTypeCode"];
	_rentalPaymentCardType = vehReservationDictionary[@"VehSegmentInfo"][@"RentalPaymentAmount"][@"PaymentCard"][@"@CardType"];
	
	/* Locations Details
	 There are two ways this go down;
	 
	 1. The pickup point and dropoff point are the same, in which case it gets returned to us as a single dictionary full of attributes.
	 2. The pickup and drop off points are different, so we get an array with two different locations back.
	 
	 We could init these both as CTLocations but I haven't designed this to persist objects so we'll have to be more verbose and deal with individual items.
	 Also worth noting here that the alternate drop off point means nothing to the app in terms of UI or receipt, so we don't need to store it at this point BUT
	 we do need the pickup details, so, lets test for Dict or Array and then parse the required section of the response.

	 */
	
	if ([vehReservationDictionary[@"VehSegmentInfo"][@"LocationDetails"] isKindOfClass:[NSArray class]]) {
		[self setLocationDetails:vehReservationDictionary[@"VehSegmentInfo"][@"LocationDetails"][0]];
	} else {
		[self setLocationDetails:vehReservationDictionary[@"VehSegmentInfo"][@"LocationDetails"]];
	}
	
	return self;
}

- (void)setCustomerEmail:(NSString *)customerEmail
{
    _customerEmail = customerEmail;
}

@end
