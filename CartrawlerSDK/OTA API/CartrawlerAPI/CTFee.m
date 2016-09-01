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
    NSNumber *amount = [formatter numberFromString:feeDictionary[@"@Amount"]];
    
    _feeAmount = amount;
	_feeCurrencyCode = feeDictionary[@"@CurrencyCode"];
	_feePurpose = feeDictionary[@"@Purpose"];
	
	if ([self.feePurpose isEqualToString:@"22"]) {
		_feePurposeDescription = @"Deposit fee, taken at confirmation.";
	}
	if ([self.feePurpose isEqualToString:@"23"]) {
		_feePurposeDescription = @"Fee to pay on arrival.";
	}
	if ([self.feePurpose isEqualToString:@"6"]) {
		_feePurposeDescription = @"Cartrawler booking fee.";
	}
	
	return self;
}

@end
