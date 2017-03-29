//
//  CTCarouselFooterView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarouselFooterView.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import "CTInPathLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTCarouselFooterView()

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *perDayLabel;
@property (nonatomic, strong) CTButton *button;

@end

@implementation CTCarouselFooterView

- (void)setDisableButtonInteraction:(BOOL)disableButtonInteraction
{
    self.button.userInteractionEnabled = !disableButtonInteraction;
}

- (instancetype)init
{
    self = [super init];
    
    UIView *thinSeperator = [UIView new];
    thinSeperator.translatesAutoresizingMaskIntoConstraints = NO;
    thinSeperator.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self addSubview:thinSeperator];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view(0.5)]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : thinSeperator}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : thinSeperator}]];
    
    _priceLabel = [UILabel new];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.priceLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.priceLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.priceLabel}]];
    
    _perDayLabel = [UILabel new];
    self.perDayLabel.textAlignment = NSTextAlignmentLeft;
    self.perDayLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.perDayLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    [self addSubview:self.perDayLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[view]-0-[priceLabel]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.perDayLabel, @"priceLabel" : self.priceLabel}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"view" : self.perDayLabel}]];
    
    _button = [[CTButton alloc] init:[UIColor clearColor]
                                       fontColor:[CTAppearance instance].headerTitleColor
                                        boldFont:YES
                                     borderColor:[CTAppearance instance].headerTitleColor];
    [self.button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.button setTitle: CTLocalizedString(CTInPathWidgetView) forState:UIControlStateNormal];
    
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.button];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[button]-4-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"button" : self.button}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button]-8-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"button" : self.button}]];
    
    [self.button addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[button(0)]"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:@{@"button" : self.button}]];
    
    return self;
}

- (void)setVehicle:(CTVehicle *)vehicle
       buttonTitle:(NSString *)buttonTitle
     disableButton:(BOOL)disableButton
       perDayPrice:(BOOL)perDayPrice
        pickupDate:(NSDate *)pickupDate
       dropoffDate:(NSDate *)dropoffDate

{
    [self.button setTitle:buttonTitle forState:UIControlStateNormal];
    self.button.userInteractionEnabled = !disableButton;
    
    if (perDayPrice) {
        self.perDayLabel.text = CTLocalizedString(CTInPathWidgetPerDay);
        self.priceLabel.attributedText = [self attributedPriceString:[self pricePerDay:pickupDate
                                                                           dropoffDate:dropoffDate
                                                                               vehicle:vehicle
                                                                          currencyCode:vehicle.currencyCode]
                                                            currency:vehicle.currencyCode];
    } else {
        self.perDayLabel.text = CTLocalizedString(CTInPathWidgetTotal);
        self.priceLabel.attributedText = [self attributedPriceString:vehicle.totalPriceForThisVehicle.twoDecimalPlaces
                                                            currency:vehicle.currencyCode];
    }
    
    for (NSLayoutConstraint *c in self.button.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = self.button.intrinsicContentSize.width + 24;
        }
    }

}

- (NSString *)pricePerDay:(NSDate *)pickupDate
              dropoffDate:(NSDate *)dropoffDate
                  vehicle:(CTVehicle *)vehicle
             currencyCode:(NSString *)currencyCode
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:pickupDate
                                                          toDate:dropoffDate
                                                         options:0];
    
    NSNumber *pricePerDay = [NSNumber numberWithFloat:vehicle.totalPriceForThisVehicle.floatValue
                             / ([components day] ?: 1)];
    return pricePerDay.twoDecimalPlaces;
}

- (NSAttributedString *)attributedPriceString:(NSString *)price currency:(NSString *)currency
{
    NSMutableAttributedString *mutString = [NSMutableAttributedString new];
    
    NSAttributedString *priceStr = [[NSAttributedString alloc] initWithString:price
                                                                         attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].boldFontName size:14],
                                                                                      NSForegroundColorAttributeName: [UIColor blackColor]}];
    
    [mutString appendAttributedString:priceStr];
    
    NSAttributedString *newLine = [[NSAttributedString alloc] initWithString:@" "];
    [mutString appendAttributedString:newLine];
    
    NSAttributedString *currencyStr = [[NSAttributedString alloc] initWithString:currency
                                                                       attributes:@{NSFontAttributeName: [UIFont fontWithName:[CTAppearance instance].fontName size:12],
                                                                                    NSForegroundColorAttributeName: [UIColor grayColor]}];
    
    [mutString appendAttributedString:currencyStr];
    
    return mutString;
}

- (void)buttonTapped:(id)sender
{
    if (self.delegate) {
        [self.delegate didTapFooterButton];
    }
}


@end
