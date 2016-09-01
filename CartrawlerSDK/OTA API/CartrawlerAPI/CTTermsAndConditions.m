//
//  termsAndConditions.m
//  CarTrawler
//

#import "CTTermsAndConditions.h"

@implementation CTTermsAndConditions

- (instancetype)initFromAPIResponse:(NSDictionary *)dict
{
    self = [super init];
    NSMutableArray *tempTerms = [[NSMutableArray alloc] init];

    if ([dict[@"RentalConditions"] isKindOfClass:[NSArray class]]) {
        for (NSDictionary *termsDict in dict[@"RentalConditions"]) {
            CTTermAndCondition *termsAndCond = [[CTTermAndCondition alloc] initFromDictionary:termsDict];
            [tempTerms addObject:termsAndCond];
        }
    }
    _termsAndConditions = tempTerms;
    return self;
}
@end
