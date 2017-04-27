//
//  ExtraEquipment.m
//  CarTrawler
//
//

#import "CTExtraEquipment.h"

@implementation CTExtraEquipment

- (instancetype)initFromDictionary:(NSDictionary *)dict {
    self = [super init];

    NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
    [numFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

	_chargeAmount = [numFormatter numberFromString:dict[@"Charge"][@"@Amount"]];
    
    if ([dict[@"Charge"][@"@IncludedInRate"] isEqualToString:@"true"]) {
        _isIncludedInRate = YES;
    } else {
        _isIncludedInRate = NO;
    }
    
    if ([dict[@"Charge"][@"@TaxInclusive"] isEqualToString:@"true"]) {
        _isTaxInclusive = YES;
    } else {
        _isTaxInclusive = NO;
    }
    
	_currencyCode = dict[@"Charge"][@"@CurrencyCode"];
	
	_equipType = dict[@"Equipment"][@"@EquipType"];
    _equipmentType = [self equipmentTypeForEquipmentTypeCode:_equipType];
	_equipDescription = dict[@"Equipment"][@"Description"];
	_qty = 0;
	return self;
}

- (CTExtraEquipmentType)equipmentTypeForEquipmentTypeCode:(NSString *)string {
    if ([string isEqualToString:@"1"]) {
        return CTExtraEquipmentTypeMobilePhone;
    }
    if ([string isEqualToString:@"3"]) {
        return CTExtraEquipmentTypeLuggageRack;
    }
    if ([string isEqualToString:@"4"]) {
        return CTExtraEquipmentTypeSkiRack;
    }
    if ([string isEqualToString:@"7"]) {
        return CTExtraEquipmentTypeInfantSeat;
    }
    if ([string isEqualToString:@"8"]) {
        return CTExtraEquipmentTypeToddlerSeat;
    }
    if ([string isEqualToString:@"9"]) {
        return CTExtraEquipmentTypeBoosterSeat;
    }
    if ([string isEqualToString:@"10"]) {
        return CTExtraEquipmentTypeSnowChains;
    }
    if ([string isEqualToString:@"13"]) {
        return CTExtraEquipmentTypeNavigationSystem;
    }
    if ([string isEqualToString:@"14"]) {
        return CTExtraEquipmentTypeSnowTires;
    }
    if ([string isEqualToString:@"30"]) {
        return CTExtraEquipmentTypeWinterPackage;
    }
    if ([string isEqualToString:@"34"]) {
        return CTExtraEquipmentTypeNavigationalPhone;
    }
    if ([string isEqualToString:@"36"]) {
        return CTExtraEquipmentTypeSkiEquipped;
    }
    if ([string isEqualToString:@"52"]) {
        return CTExtraEquipmentTypeTollTag;
    }
    if ([string isEqualToString:@"55"]) {
        return CTExtraEquipmentTypeWifi;
    }
    if ([string isEqualToString:@"101.EQP"]) {
        return CTExtraEquipmentTypeAdditionalDriver;
    }
    if ([string isEqualToString:@"102.EQP"]) {
        return CTExtraEquipmentTypeGPS;
    }
    if ([string isEqualToString:@"103.EQP"]) {
        return CTExtraEquipmentTypeBreathalyser;
    }
    if ([string isEqualToString:@"104.EQP"]) {
        return CTExtraEquipmentTypeSnowCover;
    }
    return CTExtraEquipmentTypeGenericExtra;
}

@end
