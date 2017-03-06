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



- (void)awakeFromNib
{
    [super awakeFromNib];
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
}
    
- (void)setSpecialOffer:(NSString *)offerText
{
    
    NSString *specialOfferPrefix = CTLocalizedString(CTRentalIncludedTitle);
    
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@",specialOfferPrefix, offerText];
    self.textLabel.textAlignment = NSTextAlignmentLeft;
    self.backgroundColor = [CTAppearance instance].merchandisingSpecialOffer;
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.adjustsFontSizeToFitWidth = YES;

    self.hidden = NO;
    
    CGSize textSize = [self.textLabel.text
                       sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:[CTAppearance instance].boldFontName size:12]}];
    
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = textSize.width + 8;
        }
    }
}

- (void)setBannerType:(CTMerhandisingBannerType)bannerType
{
    switch (bannerType) {
        case CTMerhandisingBannerTypeBestSeller:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleBestSeller);
            self.backgroundColor = [CTAppearance instance].merchandisingBestSeller;
            self.textLabel.textColor = [UIColor whiteColor];
            self.hidden = NO;
            break;
            
        case CTMerhandisingBannerTypeGreatValue:
            self.textLabel.text = CTLocalizedString(CTRentalVehicleGreatValue);
            self.backgroundColor = [CTAppearance instance].merchandisingGreatValue;
            self.textLabel.textColor = [UIColor whiteColor];
            self.hidden = NO;
            break;
            
        case CTMerhandisingBannerTypeNone:
            self.hidden = YES;
            break;
            
        default:
            break;
    }
    
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = self.textLabel.intrinsicContentSize.width + 12;
        }
    }
}

@end
