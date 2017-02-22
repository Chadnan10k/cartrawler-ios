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
    _feePurpose = [self feePurpose:feeDictionary[@"@Purpose"]];

	return self;
}

- (CTFeeType)feePurpose:(NSString *)fromString
{
    
    if ([fromString isEqualToString:@"6"]) {
        return CTFeeTypeBooking;
    }
    
    if ([fromString isEqualToString:@"21"]) {
        return CTFeeTypePartialPayed;
    }
    
    if ([fromString isEqualToString:@"22"]) {
        return CTFeeTypePayNow;
    }
    
    if ([fromString isEqualToString:@"23"]) {
        return CTFeeTypePayAtDesk;
    }
    
    if ([fromString isEqualToString:@"101.VCP.X"]) {
        return CTFeeTypePriceMinusFee;
    }
    
    if ([fromString isEqualToString:@"102.VCP.X"]) {
        return CTFeeTypePayDaily;
    }
    
    if ([fromString isEqualToString:@"104.VCP.X"]) {
        return CTFeeTypePayWeekly;
    }
    
    if ([fromString isEqualToString:@"105.VCP.X"]) {
        return CTFeeTypePayMonthly;
    }
    
    if ([fromString isEqualToString:@"801.VCP.X"]) {
        return CTFeeTypePrepaidDepositFee;
    }
    
    if ([fromString isEqualToString:@"802.VCP.X"]) {
        return CTFeeTypePrepaidDepositTotalFee;
    }
    
    if ([fromString isEqualToString:@"803.VCP.X"]) {
        return CTFeeTypePrepaidDepositRemainderFee;
    }
    
    return nil;
}

@end
