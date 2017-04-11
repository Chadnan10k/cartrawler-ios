//
//  CTMerhandisingBanner.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTMerhandisingBanner.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTMerhandisingBanner()

@property (nonatomic, strong) CTLabel *textLabel;

@end

@implementation CTMerhandisingBanner

- (instancetype)init
{
    self = [super init];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    _textLabel = [CTLabel new];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.useBoldFont = YES;
    self.textLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:12];
    
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[text]-4-|" options:0
                                                                 metrics:nil
                                                                   views:@{ @"text" : self.textLabel }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[text]-4-|" options:0
                                                                 metrics:nil
                                                                   views:@{ @"text" : self.textLabel }]];
    
    self.layer.cornerRadius = 5;
    return self;
}
    
- (void)setSpecialOffer:(NSString *)offerText
{
    
    NSString *specialOfferPrefix = CTLocalizedString(CTRentalIncludedTitle);
    
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@",specialOfferPrefix, offerText];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.backgroundColor = [CTAppearance instance].merchandisingSpecialOffer;
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.adjustsFontSizeToFitWidth = YES;

    self.hidden = [offerText isEqualToString:@""];
    
    CGSize textSize = [self.textLabel.text
                       sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:12]}];
    
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = textSize.width + 8;
        }
    }
}

- (void)setBanner:(CTMerchandisingTag)merchandisingTag specialOffers:(NSArray <CTSpecialOffer *> *)specialOffers
{
    CTSpecialOffer *choosenOffer;
    for (CTSpecialOffer *so in specialOffers) {
        
        if (so.type == CTSpecialOfferTypeCartrawlerCash ||
            so.type == CTSpecialOfferTypePercentageDiscount ||
            so.type == CTSpecialOfferTypePercentageDiscountBranded ||
            so.type == CTSpecialOfferTypeGenericDiscount ||
            so.type == CTSpecialOfferTypeGenericDiscountBranded)
        {
            choosenOffer = so;
        }
    }
    
    if (choosenOffer) {
        [self setFromSpecialOffer:choosenOffer];//we need some login on weighting atm we are happy to display any one of these in priority of the merch tag
    } else {
        [self setFromMerchandisingTag:merchandisingTag];
    }
    
    self.hidden = [self.textLabel.text isEqualToString:@""];
    
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = self.textLabel.intrinsicContentSize.width + 12;
        }
    }
}

- (void)setFromMerchandisingTag:(CTMerchandisingTag)merchandisingTag
{
    [self setColor:merchandisingTag];
    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingBusiness);
            break;
            
        case CTMerchandisingTagCityBreak:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingCityBreak);
            break;
            
        case CTMerchandisingTagFamilySize:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingFamilySize);
            break;
            
        case CTMerchandisingTagBestSeller:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingBestSeller);
            break;
            
        case CTMerchandisingTagGreatValue:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingGreatValue);
            break;
            
        case CTMerchandisingTagQuickestQueue:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingQuickestQueue);
            break;
            
        case CTMerchandisingTagRecommended:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingRecommended);
            break;
            
        case CTMerchandisingTagUpgradeTo:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingUpgradeTo);
            break;
            
        case CTMerchandisingTagOnBudget:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingOnBudget);
            break;
            
        case CTMerchandisingTagBestReviewed:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleMerchandisingBestReviewed);
            break;
            
        case CTMerchandisingTagUnknown:
            self.textLabel.text = @"";
            break;
    }
}

- (void)setFromSpecialOffer:(CTSpecialOffer *)specialOffer
{
    self.textLabel.text = specialOffer.shortText;
}

- (void)setColor:(CTMerchandisingTag)merchandisingTag
{
    self.textLabel.textColor = [UIColor whiteColor];

    switch (merchandisingTag) {
        case CTMerchandisingTagBusiness:
            self.backgroundColor = [UIColor colorWithRed:75.0/255.0 green:75.0/255.0 blue:75.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagCityBreak:
            self.backgroundColor = [UIColor colorWithRed:4.0/255.0 green:119.0/255.0 blue:188.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagFamilySize:
            self.backgroundColor = [UIColor colorWithRed:189.0/255.0 green:15.0/255.0 blue:134.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagBestSeller:
            self.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagGreatValue:
            self.backgroundColor = [UIColor colorWithRed:41.0/255.0 green:173.0/255.0 blue:79.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagQuickestQueue:
            self.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:90.0/255.0 blue:0.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagRecommended:
            self.backgroundColor = [UIColor colorWithRed:254.0/255.0 green:67.0/255.0 blue:101.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagUpgradeTo:
            self.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagOnBudget:
            self.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagBestReviewed:
            self.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            break;
            
        case CTMerchandisingTagUnknown:
            self.backgroundColor = [UIColor colorWithRed:22.0/255.0 green:171.0/255.0 blue:252.0/255.0 alpha:1];
            break;
    }
}

@end
