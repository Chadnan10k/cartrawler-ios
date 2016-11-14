//
//  Car.m
//  CarTrawler
//
//

#import "CTVehicle.h"
#import "CTPricedCoverage.h"
#import "CTVehicleCharge.h"
#import "CTExtraEquipment.h"
#import "CartrawlerAPI+NSURL.h"

@interface CTVehicle()

@end

@implementation CTVehicle

- (NSNumber *)calculateTotalPriceForThisCar {
	NSNumber *total = @0.00;
    
	if ((self.fees).count > 0) {
		
		for (CTFee *f in self.fees) {
                        
			if ([f.feePurpose isEqualToString:@"22"]) {
				//Deposit
				total = @(f.feeAmount.doubleValue + total.doubleValue);
				
			} else if ([f.feePurpose isEqualToString:@"23"]) {
				// Pay on Arrival
				total = @(f.feeAmount.doubleValue + total.doubleValue);
				
			} else if ([f.feePurpose isEqualToString:@"6"]) {
				// Booking Fee amount
				total = @(f.feeAmount.doubleValue + total.doubleValue);
			} 
		}
	}
	
	return total;
	
}
- (instancetype)initFromDictionary:(NSDictionary *)dictionary;
{
	
    self = [super init];
    
    _indexation = [[CTVehicleIndexation alloc] initFromDictionary:dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"Indexation"]];
    
    NSMutableArray *tempSpecialOffers = [[NSMutableArray alloc] init];
    
    if ([dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"SpecialOffers"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *offerDict in dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"SpecialOffers"]) {
            [tempSpecialOffers addObject:[[CTSpecialOffer alloc] initFromDictionary: offerDict]];
        }
        _specialOffers = tempSpecialOffers;
    } else {
        
        CTSpecialOffer *specialOffer = [[CTSpecialOffer alloc] initFromDictionary:dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"SpecialOffers"]];
        if (specialOffer) {
            _specialOffers = @[specialOffer];
        }
    }

    _config = [[CTVehicleConfig alloc] initFromDictionary:dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"Config"]];
    
    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    
    _orderIndex = [numFormatter numberFromString:dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"OrderBy"][@"@Index"]];
	
	if ([dictionary[@"VehAvailCore"][@"@Status"] isEqualToString:@"Available"]) {
		_isAvailable = YES;
	} else {
		_isAvailable = NO;
	}
    
	_isAirConditioned = [dictionary[@"VehAvailCore"][@"Vehicle"][@"@AirConditionInd"] boolValue];
	
	_transmissionType = dictionary[@"VehAvailCore"][@"Vehicle"][@"@TransmissionType"];	
	
	_fuelType = dictionary[@"VehAvailCore"][@"Vehicle"][@"@FuelType"];
	
	_driveType = dictionary[@"VehAvailCore"][@"Vehicle"][@"@DriveType"];
	
    _passengerQty = [numFormatter numberFromString: dictionary[@"VehAvailCore"][@"Vehicle"][@"@PassengerQuantity"]];

	_baggageQty = [numFormatter numberFromString: dictionary[@"VehAvailCore"][@"Vehicle"][@"@BaggageQuantity"]];
	
	_code = dictionary[@"VehAvailCore"][@"Vehicle"][@"@Code"];
	
	_codeContext = dictionary[@"VehAvailCore"][@"Vehicle"][@"@CodeContext"];
	
	_size = [self vehcileCategoryStringFromNumber:dictionary[@"VehAvailCore"][@"Vehicle"][@"VehType"][@"@VehicleCategory"]];
    
    _sizeCode = dictionary[@"VehAvailCore"][@"Vehicle"][@"VehType"][@"@VehicleCategory"];
	
	_doorCount = [numFormatter numberFromString:dictionary[@"VehAvailCore"][@"Vehicle"][@"VehType"][@"@DoorCount"]];
	
	_classSize = [dictionary[@"VehAvailCore"][@"Vehicle"][@"VehClass"][@"@Size"] integerValue];
    
    if (dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"VehMakeModel"][@"@Name"] && dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"VehMakeModel"][@"@orSimiliar"]) {
        _makeModelName = dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"VehMakeModel"][@"@Name"];
        _orSimilar = dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"VehMakeModel"][@"@orSimiliar"];
    } else {
        _makeModelName = dictionary[@"VehAvailCore"][@"Vehicle"][@"VehMakeModel"][@"@Name"];
        _orSimilar = @"";
    }

	_makeModelCode = dictionary[@"VehAvailCore"][@"Vehicle"][@"VehMakeModel"][@"@Code"];
	
    _pictureURL = [NSURL vehicle:dictionary[@"VehAvailCore"][@"Vehicle"][@"PictureURL"]];
	
	_vehicleAssetNumber = dictionary[@"VehAvailCore"][@"Vehicle"][@"VehIdentity"][@"@VehicleAssetNumber"];
	
	// Rental Rate Data
		
	NSMutableArray *thisCarsCharges = dictionary[@"VehAvailCore"][@"RentalRate"][@"VehicleCharges"];
    NSMutableArray *tempCarsCharges = [[NSMutableArray alloc] init];

	for (int i = 0; i < thisCarsCharges.count; i++) {
		CTVehicleCharge *vc = [[CTVehicleCharge alloc] initFromVehicleChargesDictionary:thisCarsCharges[i]];
		[tempCarsCharges addObject:vc];
	}
    _vehicleCharges = tempCarsCharges;
	_rateQualifier = dictionary[@"VehAvailCore"][@"RentalRate"][@"RateQualifier"][@"@RateQualifier"];
	
	// Reference Data
	// ==============
	
	_refType = dictionary[@"VehAvailCore"][@"Reference"][@"@Type"];
	_refID = dictionary[@"VehAvailCore"][@"Reference"][@"@ID"];
	_refIDContext = dictionary[@"VehAvailCore"][@"Reference"][@"@ID_Context"];
	_refTimeStamp = dictionary[@"VehAvailCore"][@"Reference"][@"@DateTime"];
	_refURL = dictionary[@"VehAvailCore"][@"Reference"][@"@URL"];
	
	// TPA_Extensions
	// ==============
	
	_needCCInfo = [dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"CC_Info"][@"@Required"] boolValue];
	_rentalDuration = dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"Duration"][@"@Days"];
	_insuranceAvailable = [dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"Insurance"][@"@avail"] boolValue];
	_fuelPolicyDescription = dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"FuelPolicy"][@"@Description"];
    _fuelPolicy = [self fuelPolicyFromString:dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"FuelPolicy"][@"@Type"]];
	// Fees Array
	// ==========

	NSMutableArray *tempFees = dictionary[@"VehAvailCore"][@"Fees"];
    NSMutableArray *tempFeesStore = [[NSMutableArray alloc] init];

	for (int i = 0; i < tempFees.count; i++) {
		CTFee *f = [[CTFee alloc] initFromFeeDictionary:tempFees[i]];
		[tempFeesStore addObject:f];
	}
	_currencyExchangeRate = dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"CurrencyExchange"][@"@Rate"];
	_currencyExchangeRate23 = dictionary[@"VehAvailCore"][@"TPA_Extensions"][@"CurrencyExchange"][@"@Rate23"];
    _fees = tempFeesStore;
	// Extra Equipment
	// ===============

    NSMutableArray *extras = dictionary[@"VehAvailCore"][@"PricedEquips"];
    NSMutableArray *tempExtras = [[NSMutableArray alloc] init];

    for (int i = 0; i < extras.count; i++) {
        CTExtraEquipment *ex = [[CTExtraEquipment alloc] initFromDictionary:extras[i]];
        [tempExtras addObject:ex];
    }
    _extraEquipment = tempExtras;
		
	// Included in Price items
	// =======================
	
	NSMutableArray *tempPricedCoverages = [[NSMutableArray alloc] init];
	// Apologies for the lovely nest you find before you.  Turns out testing for included extras is a little complicated...
	
	if (dictionary[@"VehAvailInfo"]) { // Does the key exist?
		if ([dictionary[@"VehAvailInfo"] isKindOfClass:[NSArray class]]) { // Is it an array?
			
			if (!([dictionary[@"VehAvailInfo"] count] > 0)) { // Is it empty?
				NSArray *array = dictionary[@"VehAvailInfo"];
				if (array.count > 0) {
					if ([dictionary[@"VehAvailInfo"][@"PricedCoverages"] isKindOfClass:[NSArray class]]) { // Get the included bits
						
						NSArray *temp = dictionary[@"VehAvailInfo"][@"PricedCoverages"];
						
						for (int i = 0; i < temp.count; i++) {
							CTPricedCoverage *pc = [[CTPricedCoverage alloc] initWithPricedCoveragesDictionary:temp[i]];
							[tempPricedCoverages addObject:pc];
						}
					}
				}
			}

		} else if ([dictionary[@"VehAvailInfo"] isKindOfClass:[NSDictionary class]]) {
			if ([dictionary[@"VehAvailInfo"][@"PricedCoverages"] isKindOfClass:[NSArray class]]) { // Get the included bits
				
				NSArray *temp = dictionary[@"VehAvailInfo"][@"PricedCoverages"];
				
				for (int i = 0; i < temp.count; i++) {
					CTPricedCoverage *pc = [[CTPricedCoverage alloc] initWithPricedCoveragesDictionary:temp[i]];
					[tempPricedCoverages addObject:pc];
				}
			}
		}
	}
    
    _pricedCoverages = tempPricedCoverages;
	_totalPriceForThisVehicle = [self calculateTotalPriceForThisCar];
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    
    _estimatedTotalAmount = [f numberFromString:dictionary[@"VehAvailCore"][@"TotalCharge"][@"@EstimatedTotalAmount"]];
    _rateTotalAmount = dictionary[@"VehAvailCore"][@"TotalCharge"][@"@RateTotalAmount"];
    _currencyCode = dictionary[@"VehAvailCore"][@"TotalCharge"][@"@CurrencyCode"];
    
	return self;
}

- (FuelPolicy)fuelPolicyFromString:(NSString *)fuelPolicy
{
    if ([fuelPolicy isEqualToString:@"ELECTRICVEHICLE"]) {
        return FuelPolicyElectricVehicle;
    }
    
    if ([fuelPolicy isEqualToString:@"FULLFULL"]) {
        return FuelPolicyFullToFull;
    }
    
    if ([fuelPolicy isEqualToString:@"EMPTYEMPTY"]) {
        return FuelPolicyEmptyToEmpty;
    }
    
    if ([fuelPolicy isEqualToString:@"FULLEMPTY"]) {
        return FuelPolicyFullToEmpty;
    }
    
    if ([fuelPolicy isEqualToString:@"HALFEMPTY"]) {
        return FuelPolicyHalfToEmpty;
    }
    
    if ([fuelPolicy isEqualToString:@"QUARTEREMPTY"]) {
        return FuelPolicyQuarterToEmpty;
    }
    
    if ([fuelPolicy isEqualToString:@"HALFHALF"]) {
        return FuelPolicyHalfToHalf;
    }
    
    if ([fuelPolicy isEqualToString:@"QUARTERQUARTER"]) {
        return FuelPolicyQuarterToQuarter;
    }
    
    if ([fuelPolicy isEqualToString:@"UNKNOWN"]) {
        return FuelPolicyUnknown;
    }
    
    if ([fuelPolicy isEqualToString:@"FULLEMPTYREFUND"]) {
        return FuelPolicyFullEmptyRefund;
    }
    
    if ([fuelPolicy isEqualToString:@"FULLFULLHYBRID"]) {
        return FuelPolicyFullToFullHybrid;
    }
    
    if ([fuelPolicy isEqualToString:@"CHAUFFULFUL"]) {
        return FuelPolicyChaufFullFull;
    }
    
    if ([fuelPolicy isEqualToString:@"CHAUFFUELINC"]) {
        return FuelPolicyChaufFuelInc;
    }
    
    return FuelPolicyUnknown;
}


- (VehicleSize)vehcileCategoryStringFromNumber:(NSString *)vehCatStr {
    if ([vehCatStr isEqualToString:@"1"]) {
        return VehicleSizeMini;
    } else if ([vehCatStr isEqualToString:@"2"]) {
        return VehicleSizeSubcompact;
    } else if ([vehCatStr isEqualToString:@"3"]) {
        return VehicleSizeEconomy;
    } else if ([vehCatStr isEqualToString:@"4"]) {
        return VehicleSizeCompact;
    } else if ([vehCatStr isEqualToString:@"5"]) {
        return VehicleSizeMidsize;
    } else if ([vehCatStr isEqualToString:@"6"]) {
        return VehicleSizeIntermediate;
    } else if ([vehCatStr isEqualToString:@"7"]) {
        return VehicleSizeStandard;
    } else if ([vehCatStr isEqualToString:@"8"]) {
        return VehicleSizeFullsize;
    } else if ([vehCatStr isEqualToString:@"9"]) {
        return VehicleSizeLuxury;
    } else if ([vehCatStr isEqualToString:@"10"]) {
        return VehicleSizePremium;
    } else if ([vehCatStr isEqualToString:@"11"]) {
        return VehicleSizeMinivan;
    } else if ([vehCatStr isEqualToString:@"12"]) {
        return VehicleSizeTwelvePassengerVan;
    } else if ([vehCatStr isEqualToString:@"13"]) {
        return VehicleSizeMovingVan;
    } else if ([vehCatStr isEqualToString:@"14"]) {
        return VehicleSizeFifteenPassengerVan;
    } else if ([vehCatStr isEqualToString:@"15"]) {
        return VehicleSizeCargoVan;
    } else if ([vehCatStr isEqualToString:@"16"]) {
        return VehicleSizeTwelveFootTruck;
    } else if ([vehCatStr isEqualToString:@"17"]) {
        return VehicleSizeTwentyFootTruck;
    } else if ([vehCatStr isEqualToString:@"18"]) {
        return VehicleSizeTwentyFourFootTruck;
    } else if ([vehCatStr isEqualToString:@"19"]) {
        return VehicleSizeTwentySixFootTruck;
    } else if ([vehCatStr isEqualToString:@"20"]) {
        return VehicleSizeMoped;
    } else if ([vehCatStr isEqualToString:@"21"]) {
        return VehicleSizeStretch;
    } else if ([vehCatStr isEqualToString:@"22"]) {
        return VehicleSizeRegular;
    } else if ([vehCatStr isEqualToString:@"23"]) {
        return VehicleSizeUnique;
    } else if ([vehCatStr isEqualToString:@"24"]) {
        return VehicleSizeExotic;
    } else if ([vehCatStr isEqualToString:@"25"]) {
        return VehicleSizeSmallMediumTruck;
    } else if ([vehCatStr isEqualToString:@"26"]) {
        return VehicleSizeLargeTruck;
    } else if ([vehCatStr isEqualToString:@"27"]) {
        return VehicleSizeSmallSUV;
    } else if ([vehCatStr isEqualToString:@"28"]) {
        return VehicleSizeMediumSUV;
    } else if ([vehCatStr isEqualToString:@"29"]) {
        return VehicleSizeLargeSUV;
    } else if ([vehCatStr isEqualToString:@"30"]) {
        return VehicleSizeExoticSUV;
    } else if ([vehCatStr isEqualToString:@"31"]) {
        return VehicleSizeFourWheelDrive;
    } else if ([vehCatStr isEqualToString:@"32"]) {
        return VehicleSizeSpecial;
    } else if ([vehCatStr isEqualToString:@"33"]) {
        return VehicleSizeMiniElite;
    } else if ([vehCatStr isEqualToString:@"34"]) {
        return VehicleSizeEconomyElite;
    } else if ([vehCatStr isEqualToString:@"35"]) {
        return VehicleSizeCompactElite;
    } else if ([vehCatStr isEqualToString:@"36"]) {
        return VehicleSizeIntermediateElite;
    } else if ([vehCatStr isEqualToString:@"37"]) {
        return VehicleSizeStandardElite;
    } else if ([vehCatStr isEqualToString:@"38"]) {
        return VehicleSizeFullsizeElite;
    } else if ([vehCatStr isEqualToString:@"39"]) {
        return VehicleSizePremiumElite;
    } else if ([vehCatStr isEqualToString:@"40"]) {
        return VehicleSizeLuxuryElite;
    } else if ([vehCatStr isEqualToString:@"41"]) {
        return VehicleSizeOversize;
    } else {
        return VehicleSizeUnknown;
    }
}

@end
