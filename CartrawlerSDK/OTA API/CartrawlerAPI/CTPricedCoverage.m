//
//  PricedCoverage.m
//  CarTrawler
//
//

#import "CTPricedCoverage.h"


@implementation CTPricedCoverage

- (instancetype)initWithPricedCoveragesDictionary:(NSDictionary *)pricedCoveragesDictionary
{
    self = [super init];
	_coverageType = pricedCoveragesDictionary[@"Coverage"][@"@CoverageType"];
	_chargeDescription = pricedCoveragesDictionary[@"Charge"][@"@Description"];
	_isTaxInclusive = [pricedCoveragesDictionary[@"Charge"][@"@TaxInclusive"] boolValue];
	_isIncludedInRate = [pricedCoveragesDictionary[@"Charge"][@"@IncludedInRate"] boolValue];
		
	return self;
}

@end
