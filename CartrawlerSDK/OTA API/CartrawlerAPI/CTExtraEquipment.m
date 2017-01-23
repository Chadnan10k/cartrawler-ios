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
	_equipDescription = dict[@"Equipment"][@"Description"];
	_qty = 0;
	return self;
}

- (void)setQty:(NSInteger)qty
{
    _qty = qty;
}

@end
