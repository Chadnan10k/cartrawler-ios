//
//  PaymentRequest.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTPaymentRequestGenerator.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTSDKSettings.h"

@implementation CTPaymentRequestGenerator

+ (NSString *)requestFromSearch:(CTRentalSearch *)search
{
	NSString *req = [self OTA_VehResRQ:[search.pickupDate stringFromDateWithFormat:@"yyyy-MM-dd'T'HH:mm:ss"]
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
							  cityName:search.city
							  postCode:search.postcode
						   countryName:[CTSDKSettings instance].homeCountryCode
						   phoneNumber:search.phone
					   insuranceObject:search.insurance
					 isBuyingInsurance:search.isBuyingInsurance
							  clientID:[CTSDKSettings instance].clientId
								target:[CTSDKSettings instance].target
								locale:[CTSDKSettings instance].languageCode
							  currency:[CTSDKSettings instance].currencyCode];
	
	return req;
}

+ (NSString *) OTA_VehResRQ:(NSString *)pickupDateTime
			 returnDateTime:(NSString *)returnDateTime
		 pickupLocationCode:(NSString *)pickupLocationCode
		dropoffLocationCode:(NSString *)dropoffLocationCode
				homeCountry:(NSString *)homeCountry
				  driverAge:(NSString *)driverAge
			  numPassengers:(NSString *)numPassengers
			   flightNumber:(NSString *)flightNumber
					  refID:(NSString *)refID
			   refTimeStamp:(NSString *)refTimeStamp
					 refURL:(NSString *)refURL
				extrasArray:(NSArray *)extrasArray
				  givenName:(NSString *)givenName
					surName:(NSString *)surName
			   emailAddress:(NSString *)emailAddress
					address:(NSString *)address
				   cityName:(NSString *)cityName
				   postCode:(NSString *)postCode
				countryName:(NSString *)countryName
				phoneNumber:(NSString *)phoneNumber
			insuranceObject:(CTInsurance *)ins
		  isBuyingInsurance:(BOOL)isBuyingInsurance
				   clientID:(NSString *)clientID
					 target:(NSString *)target
					 locale:(NSString *)locale
				   currency:(NSString *)currency

{
	
	NSString *insuranceJson = @"";
	NSString *addressLine = @"";
	
	if (isBuyingInsurance) {
		insuranceJson =     [NSString stringWithFormat:@"\"Reference\":{\"@Type\":\"16\"\r,\"@ID\":\"%@\"\r,\"@ID_Context\":\"INSURANCE\"\r,\"@Amount\":\"%@\"\r,\"@CurrencyCode\":\"%@\"\r,\"@URL\":\"%@\"},", ins.planID, ins.premiumAmount, ins.premiumCurrencyCode, ins.termsAndConditionsURL];
		
		addressLine = [NSString stringWithFormat:@"%@", address];
	}
	
	NSString *extrasString = @"";
	NSMutableArray *validExtras = [[NSMutableArray alloc] init];
	
	for (CTExtraEquipment *e in extrasArray) {
		if (e.qty > 0) {
			[validExtras addObject:e];
		}
	}
	
	if (validExtras.count > 0) {
		
		extrasString = [extrasString stringByAppendingString:@",\"SpecialEquipPrefs\":{\"SpecialEquipPref\":[\r"];
		for (int i = 0; i < validExtras.count; i++) {
			CTExtraEquipment *e = (CTExtraEquipment *)validExtras[i];
			if (e.qty != 0) {
				extrasString = [extrasString stringByAppendingString:[NSString stringWithFormat:@"{\"@EquipType\":\"%@\",\"@Quantity\":\"%li\"}\r",e.equipType, (long)e.qty]];
				if (validExtras.count > 1) {
					if ((i + 1) != (validExtras.count)) {
						extrasString = [extrasString stringByAppendingString:@","];
					}
				}
			}
		}
		extrasString = [extrasString stringByAppendingString:@"]}\r"];
	} else {
		extrasString = @"";
	}
	
	NSString *flightDetails = @"";
	
	if (flightNumber != nil && flightNumber.length > 2) {
		NSString *flightNumberPrefixString = [flightNumber substringToIndex:2];
		NSString *flightNumberString = [flightNumber substringFromIndex:2];
		flightDetails = [NSString stringWithFormat:@"\"ArrivalDetails\":{\"@TransportationCode\":\"14\",\"@Number\":\"%@\",\"OperatingCompany\":\"%@\"}, \r", flightNumberString, flightNumberPrefixString];
	}
	
	givenName = [CTSDKSettings instance].isStandalone  ? givenName : @"[FIRSTNAME]";
	surName = [CTSDKSettings instance].isStandalone  ? surName : @"[SURNAME]";
	phoneNumber = [CTSDKSettings instance].isStandalone  ? phoneNumber : @"[TELEPHONE]";
	emailAddress = [CTSDKSettings instance].isStandalone  ? emailAddress : @"[EMAIL]";
	addressLine = [CTSDKSettings instance].isStandalone ? addressLine : @"[ADDRESSLINE1]";
	cityName = [CTSDKSettings instance].isStandalone ? cityName : @"[CITY]";
	postCode = [CTSDKSettings instance].isStandalone ? postCode : @"[POSTCODE]" ;
	countryName = [CTSDKSettings instance].isStandalone ? countryName : @"[COUNTRYNAMECODE]";
	
	NSString *jsonPthOne = [NSString stringWithFormat:
							@"{ \r"
							@"    \"@xmlns\":\"http://www.opentravel.org/OTA/2003/05\", \r"
							@"    \"@Version\":\"1.002\", \r"
							@"    \"@Target\":\"%@\", \r"
							@"    \"@PrimaryLangID\":\"%@\", \r"
							@"    \"POS\":{ \r"
							@"        \"Source\":[ \r"
							@"         { \r"
							@"            \"@ERSP_UserID\":\"MO\", \r"
							@"            \"@ISOCurrency\":\"%@\", \r"
							@"            \"RequestorID\":{ \r"
							@"                \"@Type\":\"16\", \r"
							@"                \"@ID\":\"%@\", \r"
							@"                \"@ID_Context\":\"CARTRAWLER\" \r"
							@"            } \r"
							@"        }, \r"
							@"        { \r"
							@"            \"RequestorID\":{ \r"
							@"                \"@Type\":\"16\", \r"
							@"                \"@ID\":\"%@\", \r"
							@"                \"@ID_Context\":\"ORDERID\" \r"
							@"            } \r"
							@"        } \r"
							@"    ]}, \r"
							@"    \"VehResRQCore\":{ \r"
							@"        \"@Status\":\"All\", \r"
							@"        \"VehRentalCore\":{ \r"
							@"            \"@PickUpDateTime\":\"%@\", \r"
							@"            \"@ReturnDateTime\":\"%@\", \r"
							@"            \"PickUpLocation\":{ \r"
							@"                \"@CodeContext\":\"CARTRAWLER\", \r"
							@"                \"@LocationCode\":\"%@\" \r"
							@"            }, "
							@"            \"ReturnLocation\":{ \r"
							@"                \"@CodeContext\":\"CARTRAWLER\", \r"
							@"                \"@LocationCode\":\"%@\" \r"
							@"            } \r"
							@"        }, \r"
							@"        \"Customer\":{ \r"
							@"            \"Primary\":{ \r"
							@"                \"PersonName\":{ \r"
							@"                    \"GivenName\":\"%@\", \r"
							@"                    \"Surname\":\"%@\" \r"
							@"                }, \r"
							@"                \"Telephone\":{ \r"
							@"                    \"@PhoneTechType\":\"1\", \r"
							@"                    \"@PhoneNumber\":\"%@\" \r"
							@"                }, \r"
							@"                \"Email\":{ \r"
							@"                    \"@EmailType\":\"2\", \r"
							@"                    \"#text\":\"%@\" \r"
							@"                }, \r"
							@"                \"Address\":{ \r"
							@"                    \"@Type\":\"2\", \r", target, locale, currency, clientID, [CTSDKSettings instance].clientId, pickupDateTime, returnDateTime, pickupLocationCode, dropoffLocationCode, givenName, surName, phoneNumber, emailAddress];
	
	NSString *jsonPthTwo = [NSString stringWithFormat:
							@"                    \"AddressLine\":\"%@\", \r"
							@"                    \"CityName\":\"%@\",  \r"
							@"                    \"PostalCode\":\"%@\",  \r", addressLine, cityName, postCode];
	
	NSString *jsonPthThree = [NSString stringWithFormat:
							  @"                    \"CountryName\":{ \r"
							  @"                        \"@Code\":\"%@\" \r"
							  @"                    } \r"
							  @"                }, \r"
							  @"			\"CitizenCountryName\":{ \r"
							  @"			\"@Code\":\"%@\" \r"
							  @"                } \r"
							  @"            } \r"
							  @"        }, \r"
							  @"        \"DriverType\":{  \r"
							  @"            \"@Age\":\"%@\"  \r"
							  @"        }  \r"
							  @"          %@    \r"
							  @"    },  \r"
							  @"    \"VehResRQInfo\":{ \r "
							  @"        \"@PassengerQty\":\"1\", \r "
							  @"               %@                      \r "
							  @"        \"RentalPaymentPref\":{  \r"
							  @"            \"PaymentCard\":{  \r"
							  @"                \"@CardType\":\"1\",  \r"
							  @"                \"@CardCode\":\"[CARDCODE]\",  \r"
							  @"                \"@CardNumber\":\"[CARDNUMBER]\",  \r"
							  @"                \"@ExpireDate\":\"[EXPIREDATE]\",  \r"
							  @"                \"@SeriesCode\":\"[SERIESCODE]\",  \r"
							  @"                \"CardHolderName\":\"[CARDHOLDERNAME]\" \r "
							  @"            }  \r"
							  @"        }, \r "
							  @"        \"Reference\":{  \r"
							  @"            \"@Type\":\"16\",  \r"
							  @"            \"@ID\":\"%@\", \r "
							  @"            \"@ID_Context\":\"CARTRAWLER\",  \r"
							  @"            \"@DateTime\":\"%@\",  \r"
							  @"            \"@URL\":\"%@\"  \r"
							  @"        },  \r"
							  @"        \"TPA_Extensions\":{  \r"
							  @"               %@             \r"
							  @"            \"Window\": { \r "
							  @"                \"@name\": \"IOS-V3\", \r "
							  @"                \"@engine\": \"IOS-V3\" \r "
							  @" }",countryName, homeCountry, driverAge, extrasString, flightDetails, refID, refTimeStamp, refURL, insuranceJson];
	
	NSString *persona;
	
	if ([CTSDKSettings instance].isStandalone) {
		NSString *appId = [CTSDKSettings instance].clientId;
		persona = [NSString stringWithFormat:
				   @"     ,\r "
				   @"     \"Persona\":{ \r"
				   @"           \"Characteristic\" :{ \r"
				   @"			  \"@name\":\"MyAccountId\", \r"
				   @"               \"@Value\":\"%@\", \r"
				   @"            } \r"
				   @"       }", appId];
	} else {
		NSString *appId = [CTSDKSettings instance].clientId;
		NSString *pnr = [CTSDKSettings instance].customerID;
		persona = [NSString stringWithFormat:
				   @"     ,\r "
				   @"     \"Persona\":{ \r"
				   @"           \"Characteristic\" :{ \r"
				   @"			  \"@name\":\"MyAccountId\", \r"
				   @"                 \"@Value\":\"%@\", \r"
				   @"			  \"@name\":\"VisitorId\", \r"
				   @"                 \"@Value\":\"%@\", \r"
				   @"            } \r"
				   @"       }", appId, pnr];
	}
	
	NSString *jsonPthFour = [NSString stringWithFormat:
							 @"            } \r"
							 @"        } \r"
							 @"    } \r"];
	
	jsonPthThree = [[jsonPthThree stringByAppendingString:persona] stringByAppendingString:jsonPthFour];
	
	//DEBUG
	NSString * t = [CTSDKSettings instance].isStandalone ? [jsonPthOne stringByAppendingString: jsonPthThree] : [[jsonPthOne stringByAppendingString:jsonPthTwo] stringByAppendingString:jsonPthThree];
	NSData *data = [t dataUsingEncoding:NSUTF8StringEncoding];
	NSError *error;
	id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
	if (error) {
		NSLog(@"%@", error);
	} else {
		NSLog(@"%@", json);
	}
	//DEBUG
	
	return [CTSDKSettings instance].isStandalone ? [jsonPthOne stringByAppendingString: jsonPthThree] : [[jsonPthOne stringByAppendingString:jsonPthTwo] stringByAppendingString:jsonPthThree];
}

@end
