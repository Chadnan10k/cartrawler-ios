//
//  VehicleCharge.m
//  CarTrawler
//
//

#import "CTVehicleCharge.h"

@implementation CTVehicleCharge

- (instancetype) initFromVehicleChargesDictionary:(NSDictionary *)vehicleChargesDictionary
{
    self = [super init];

	_chargeDescription = vehicleChargesDictionary[@"@Description"];
	_chargePurpose = vehicleChargesDictionary[@"@Purpose"];
	_isTaxInclusive = [vehicleChargesDictionary[@"@TaxInclusive"] boolValue];
	_isIncludedInRate = [vehicleChargesDictionary[@"@IncludedInRate"] boolValue];
	
	return self;
}

@end
