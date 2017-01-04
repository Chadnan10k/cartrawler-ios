//
//  Fee.m
//  CarTrawler
//
//

#import "CTFee.h"


@implementation CTFee

- (instancetype)initFromFeeDictionary:(NSDictionary *)feeDictionary
{
    self = [super init];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    NSNumber *amount = [formatter numberFromString:feeDictionary[@"@Amount"]];
    
    _feeAmount = amount;
	_feeCurrencyCode = feeDictionary[@"@CurrencyCode"];
	_feePurpose = feeDictionary[@"@Purpose"];

	return self;
}

@end
