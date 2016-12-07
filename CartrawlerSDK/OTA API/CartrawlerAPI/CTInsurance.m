//
//  InsuranceObject.m
//  CarTrawler
//

#import "CTInsurance.h"


@implementation CTInsurance

- (instancetype) initFromDict:(NSDictionary *)dict
{
    self = [super init];

    NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];

	_planID = dict[@"PlanForQuoteRS"][@"@PlanID"];
	_name = dict[@"PlanForQuoteRS"][@"@Name"];
    
    _termsAndConditionsTitle = dict[@"TPA_Extensions"][@"Data"][@"Links"][@"Link"][@"@Text"];
    
    _termsAndConditionsURL = [[NSURL alloc] initWithString:dict[@"PlanForQuoteRS"][@"QuoteDetail"][@"QuoteDetailURL"] ?: @""];
	_costAmount = [formatter numberFromString:dict[@"PlanForQuoteRS"][@"PlanCost"][@"@Amount"]];
	_costCurrencyCode = dict[@"PlanForQuoteRS"][@"PlanCost"][@"@CurrencyCode"];
    _premiumAmount = [formatter numberFromString:dict[@"PlanForQuoteRS"][@"PlanCost"][@"BasePremium"][@"@Amount"]];
	_premiumCurrencyCode = dict[@"PlanForQuoteRS"][@"PlanCost"][@"BasePremium"][@"@CurrencyCode"];
    
    _title = dict[@"TPA_Extensions"][@"Data"][@"Title"][@"#text"];

    _imageURL = [[NSURL alloc] initWithString:(dict[@"TPA_Extensions"][@"Data"][@"Image"][@"#text"] ?: @"")];
    
    _summary = dict[@"TPA_Extensions"][@"Data"][@"Summary"][@"#text"];
    
    _listTitle = dict[@"TPA_Extensions"][@"Data"][@"List"][@"@Title"];
    
    for (NSDictionary *d in dict[@"TPA_Extensions"][@"Data"][@"Paragraph"]) {
        
        if ([d[@"@Type"] isEqualToString:@"FOOTER"]) {
            _paragraphFooter = d[@"#text"];
        } else if ([d[@"@Type"] isEqualToString:@"INFO"]) {
            _paragraphInfo = d[@"#text"];
        } else if ([d[@"@Type"] isEqualToString:@"SUBFOOTER"]) {
            _paragraphSubfooter = d[@"#text"];
        }

    }
    
    if ([dict[@"TPA_Extensions"][@"Data"][@"Links"] isKindOfClass:[NSArray class]]) {
        NSMutableArray *linkArray = [[NSMutableArray alloc] init];
        for(NSDictionary *link in dict[@"TPA_Extensions"][@"Data"][@"Links"]) {
            [linkArray addObject:[[CTInsuranceLink alloc] initWithLink:link[@"Link"][@"@Url"] title:link[@"Link"][@"@Text"] code:link[@"Link"][@"@Code"]]];
        }
    } else {
        NSDictionary *link = dict[@"TPA_Extensions"][@"Data"][@"Links"][@"Link"];
        _links = @[ [[CTInsuranceLink alloc] initWithLink:link[@"@Url"] title:link[@"@Text"] code:link[@"@Code"]] ];
    }
    
    
    NSMutableArray *strArray = [[NSMutableArray alloc] init];
    for(NSString *s in dict[@"TPA_Extensions"][@"Data"][@"List"][@"Item"]) {
        [strArray addObject:s];
    }
    
    _listItems = strArray;

    if ([dict[@"TPA_Extensions"][@"Data"][@"Functional"][@"Option"] isKindOfClass:[NSArray class]]) {
        _functionalText = dict[@"TPA_Extensions"][@"Data"][@"Functional"][@"Option"][0][@"@Title"];
    } else {
        _functionalText = dict[@"TPA_Extensions"][@"Data"][@"Functional"][@"Option"][@"@Title"];
    }
    
    _selectorTitle = dict[@"TPA_Extensions"][@"Data"][@"SelectControl"][@"@Title"];
    NSMutableArray <CTInsuranceSelectorItem *> *selectorItemsArr = [[NSMutableArray alloc] init];
    for (NSDictionary *d in dict[@"TPA_Extensions"][@"Data"][@"SelectControl"][@"Item"]) {
        [selectorItemsArr addObject:[[CTInsuranceSelectorItem alloc] initWithName:d[@"#text"] code:d[@"@Key"]]];
    }
    _selectorItems = selectorItemsArr;
    
	return self;
}

@end

