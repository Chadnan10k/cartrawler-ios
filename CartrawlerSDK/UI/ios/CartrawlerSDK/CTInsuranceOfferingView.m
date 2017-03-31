//
//  CTInsuranceOfferingView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 09/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

//
//  CTInsuranceView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 08/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTInsuranceOfferingView.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTHTMLParser.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerAPI/CTInsurance.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>

@interface CTInsuranceOfferingView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CTLabel *headerLabel;
@property (nonatomic, strong) CTLabel *subheaderLabel;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) CTButton *addNowButton;
@property (nonatomic, strong) UIButton *termsButton;
@property (nonatomic, strong) UIView *accordionView;
@property (nonatomic, strong) CTTextView *textView;
@property (nonatomic, strong) CTInsurance *insurance;
@property (nonatomic) BOOL isOpen;

@end

@implementation CTInsuranceOfferingView

- (instancetype)init
{
    self = [super init];
    [self createBackgroundView];
    [self buildAddInsuranceState];
    return self;
}

- (void)updateInsurance:(CTInsurance *)insurance
{
    _insurance = insurance;
    [self updateText];
}

- (void)updateText
{
    NSString *addNowText = [NSString stringWithFormat:CTLocalizedString(CTRentalInsuranceAddButtonTitle), self.insurance.premiumAmount.numberStringWithCurrencyCode];
    [self.addNowButton setTitle:addNowText forState:UIControlStateNormal];
}


- (void)createBackgroundView
{
    _backgroundView = [UIView new];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundView.backgroundColor = [UIColor colorWithRed:70.0/255.0 green:144.0/255.0 blue:228.0/255.0 alpha:1];
    [self addSubview:self.backgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[backgroundView(0@100)]-0-|"
                                                                 options:0 metrics:nil
                                                                   views:@{@"backgroundView" : self.backgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[backgroundView]-0-|"
                                                                 options:0 metrics:nil
                                                                   views:@{@"backgroundView" : self.backgroundView}]];
}

- (void)buildAddInsuranceState
{
    _headerLabel = [[CTLabel alloc] init:15 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter boldFont:YES];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = CTLocalizedString(CTRentalInsuranceOfferingHeader);
    [self.backgroundView addSubview:self.headerLabel];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"label" : self.headerLabel}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"label" : self.headerLabel}]];
    
    _subheaderLabel = [[CTLabel alloc] init:12 textColor:[UIColor colorWithRed:174.0/255.0 green:210.0/255.0 blue:244.0/255.0 alpha:1] textAlignment:NSTextAlignmentCenter boldFont:NO];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.text = CTLocalizedString(CTRentalInsuranceOfferingSubheader);
    [self.backgroundView addSubview:self.subheaderLabel];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[header]-[label]"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"label" : self.subheaderLabel, @"header" : self.headerLabel}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"label" : self.subheaderLabel}]];
    
    _shieldImageView = [UIImageView new];
    self.shieldImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.shieldImageView.contentMode = UIViewContentModeScaleAspectFit;
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    UIImage *shield = [UIImage imageNamed:@"shield_offer" inBundle:b compatibleWithTraitCollection:nil];
    self.shieldImageView.image = shield;
    [self.backgroundView addSubview:self.shieldImageView];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[image(40)]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"image" : self.shieldImageView}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[image(40)]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"image" : self.shieldImageView}]];
    
    _accordionView = [self buildAccordion];
    [self.backgroundView addSubview:self.accordionView];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[label]-8-[accordion]"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"label" : self.subheaderLabel, @"accordion" : self.accordionView}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[accordion]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"accordion" : self.accordionView}]];
    
    _addNowButton = [[CTButton alloc] init:nil fontColor:nil boldFont:YES borderColor:nil];
    [self.addNowButton addTarget:self action:@selector(addInsurance:) forControlEvents:UIControlEventTouchUpInside];
    self.addNowButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addSubview:self.addNowButton];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[accordion]-[button(50)]"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.addNowButton, @"accordion" : self.accordionView}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.addNowButton}]];
    
    _termsButton = [UIButton new];
    NSMutableAttributedString *termsText = [[NSMutableAttributedString alloc] initWithString:CTLocalizedString(CTRentalInsuranceTermsConditions)];
    [termsText addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [termsText length])];
    [termsText addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, [termsText length])];
    [self.termsButton setAttributedTitle:termsText forState:UIControlStateNormal];
    [self.termsButton addTarget:self action:@selector(termsTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.termsButton.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:11];
    self.termsButton.backgroundColor = [UIColor clearColor];
    self.termsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.backgroundView addSubview:self.termsButton];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addButton]-[button(30)]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.termsButton, @"addButton" : self.addNowButton}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.termsButton}]];
}

- (UIView *)buildAccordion
{
    UIView *accordionBackground = [UIView new];
    accordionBackground.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    accordionBackground.translatesAutoresizingMaskIntoConstraints = NO;
    accordionBackground.backgroundColor = [UIColor colorWithRed:56.0/255.0 green:127.0/255.0 blue:213.0/255.0 alpha:1];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(openAccordion:)];
    [accordionBackground addGestureRecognizer:tap];
    
    [accordionBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[background(50@1000)]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"background" : accordionBackground}]];
    
    CTLabel *accordionTitle = [[CTLabel alloc] init:17 textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter boldFont:YES];
    accordionTitle.translatesAutoresizingMaskIntoConstraints = NO;
    accordionTitle.text = CTLocalizedString(CTRentalInsuranceSummaryTitle);
    accordionTitle.numberOfLines = 1;
    [accordionBackground addSubview:accordionTitle];
    [accordionBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"label" : accordionTitle}]];
    
    [accordionBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-16-[label]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"label" : accordionTitle}]];
    return accordionBackground;
}

- (void)setTextViewText:(CTInsurance *)insurance
{
    _textView = [CTTextView new];
    self.textView.text = @"";
    self.textView.backgroundColor = [UIColor clearColor];
    self.textView.scrollEnabled = NO;
    self.textView.userInteractionEnabled = NO;
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.accordionView addSubview:self.textView];
    [self.accordionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[textView(0@100)]-4-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"textView" : self.textView}]];
    [self.accordionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[textView]-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"textView" : self.textView}]];
    
    self.textView.attributedText = [self listItems:insurance];
}

- (void)addInsurance:(id)sender
{
    if (self.addAction) {
        self.addAction();
    }
}

- (void)openAccordion:(id)sender
{
    if (!self.isOpen) {
        [self setTextViewText:self.insurance];
        for (NSLayoutConstraint *c in self.accordionView.constraints) {
            if (c.firstAttribute == NSLayoutAttributeHeight) {
                c.constant = [self textViewHeight] + 50;
            }
        }
        _isOpen = YES;
    } else {
        [self.textView removeFromSuperview];
        for (NSLayoutConstraint *c in self.accordionView.constraints) {
            if (c.firstAttribute == NSLayoutAttributeHeight) {
                c.constant = 50;
            }
        }
        _isOpen = NO;
    }
}

- (NSAttributedString *)listItems:(CTInsurance *)response
{
    NSMutableAttributedString *listItems = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < response.listItems.count; ++i) {
        [listItems appendAttributedString:[CTHTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                       pointSize:15
                                                                            text:response.listItems[i]
                                                                   boldFontColor:@"#FFFFFF"
                                                                       fontColor:@"#FFFFFF"]];
        
        if (i != response.listItems.count-1) {
            [listItems appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
        }
    }
    
    return [self scanForLinks:listItems response:response];
}

- (NSAttributedString *)scanForLinks:(NSAttributedString *)attrText response:(CTInsurance *)response
{
    for (CTInsuranceLink *link in response.links) {
        
        NSString *text = attrText.string;
        NSRange range = [text rangeOfString:[NSString stringWithFormat:@"${%@}", link.code]];
        
        if (range.location != NSNotFound) {
            
            NSDictionary *linkAttr = @{ NSLinkAttributeName : link.link,
                                        NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:15]
                                        };
            
            NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
            
            NSAttributedString *attrLink = [[NSAttributedString alloc]
                                            initWithString:link.title
                                            attributes:linkAttr];
            
            [attrText replaceCharactersInRange:range withAttributedString:attrLink];
            [attrText.mutableString replaceOccurrencesOfString:@"{"
                                                    withString:@""
                                                       options:NSCaseInsensitiveSearch
                                                         range:NSMakeRange(0, attrText.string.length)];
            [attrText.mutableString replaceOccurrencesOfString:@"}"
                                                    withString:@""
                                                       options:NSCaseInsensitiveSearch
                                                         range:NSMakeRange(0, attrText.string.length)];
            
            [attrText addAttributes:@{NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:15]} range:NSMakeRange(0, attrText.string.length)];
            
            return attrText;
        } else {
            return attrText;
        }
    }
    return attrText;
}

- (CGFloat)textViewHeight
{
    CGFloat fixedWidth = self.textView.frame.size.width;
    CGSize newSize = [self.textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = self.textView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    return newFrame.size.height;
}

- (void)termsTapped:(id)sender
{
    if (self.termsAndConditionsAction) {
        self.termsAndConditionsAction();
    }
}

@end
