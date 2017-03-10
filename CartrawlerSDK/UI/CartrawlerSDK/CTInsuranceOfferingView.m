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
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTHTMLParser.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerAPI/CTInsurance.h>

@interface CTInsuranceOfferingView()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) CTLabel *headerLabel;
@property (nonatomic, strong) CTLabel *subheaderLabel;
@property (nonatomic, strong) UIImageView *shieldImageView;
@property (nonatomic, strong) UIButton *addNowButton;
@property (nonatomic, strong) UIButton *termsButton;
@property (nonatomic, strong) UIView *accordionView;
@property (nonatomic, strong) CTTextView *textView;
@property (nonatomic, strong) CTInsurance *insurance;
@property (nonatomic) BOOL isOpen;

@end

@implementation CTInsuranceOfferingView

- (instancetype)init:(CTInsurance *)insurance
{
    self = [super init];
    _insurance = insurance;
    [self createBackgroundView];
    [self buildAddInsuranceState];
    return self;
}

- (void)createBackgroundView
{
    _backgroundView = [UIView new];
    self.backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundView.backgroundColor = [UIColor yellowColor];
    [self addSubview:self.backgroundView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[backgroundView(0@100)]-|"
                                                                 options:0 metrics:nil
                                                                   views:@{@"backgroundView" : self.backgroundView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[backgroundView]-|"
                                                                 options:0 metrics:nil
                                                                   views:@{@"backgroundView" : self.backgroundView}]];
}

- (void)buildAddInsuranceState
{
    _headerLabel = [CTLabel new];
    self.headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.headerLabel.text = @"Test add insurance";
    [self.backgroundView addSubview:self.headerLabel];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[label]"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"label" : self.headerLabel}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[label]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"label" : self.headerLabel}]];
    
    _subheaderLabel = [CTLabel new];
    self.subheaderLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.subheaderLabel.text = @"Test add insurance";
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
    UIImage *shield = [UIImage imageNamed:@"insurance_shield" inBundle:b compatibleWithTraitCollection:nil];
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
    
    _addNowButton = [UIButton new];
    [self.addNowButton addTarget:self action:@selector(addInsurance:) forControlEvents:UIControlEventTouchUpInside];
    self.addNowButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.addNowButton setTitle:@"Add Test Insurance" forState:UIControlStateNormal];
    [self.backgroundView addSubview:self.addNowButton];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[accordion]-[button(40)]"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.addNowButton, @"accordion" : self.accordionView}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.addNowButton}]];
    self.addNowButton.backgroundColor = [UIColor redColor];
    
    _termsButton = [UIButton new];
    self.termsButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.termsButton setTitle:@"terms and cond" forState:UIControlStateNormal];
    [self.backgroundView addSubview:self.termsButton];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[addButton]-[button(30)]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.termsButton, @"addButton" : self.addNowButton}]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[button]-|"
                                                                                options:0 metrics:nil
                                                                                  views:@{@"button" : self.termsButton}]];
    self.termsButton.backgroundColor = [UIColor redColor];
}

- (UIView *)buildAccordion
{
    UIView *accordionBackground = [UIView new];
    accordionBackground.translatesAutoresizingMaskIntoConstraints = NO;
    accordionBackground.backgroundColor = [UIColor greenColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(openAccordion:)];
    [accordionBackground addGestureRecognizer:tap];
    
    [accordionBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[background(40@1000)]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"background" : accordionBackground}]];
    
    CTLabel *accordionTitle = [CTLabel new];
    accordionTitle.translatesAutoresizingMaskIntoConstraints = NO;
    accordionTitle.text = @"Why get full test";
    accordionTitle.numberOfLines = 1;
    accordionTitle.textAlignment = NSTextAlignmentCenter;
    [accordionBackground addSubview:accordionTitle];
    [accordionBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[label]-8-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"label" : accordionTitle}]];
    
    [accordionBackground addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[label]"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"label" : accordionTitle}]];
    return accordionBackground;
}

- (void)setTextViewText:(CTInsurance *)insurance
{
    _textView = [CTTextView new];
    self.textView.text = @"";
    //    self.textView.alpha = 0;
    self.textView.scrollEnabled = NO;
    self.textView.userInteractionEnabled = NO;
    self.textView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.accordionView addSubview:self.textView];
    [self.accordionView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-32-[textView(0@100)]-4-|"
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
                c.constant = [self textViewHeight] + 28;
            }
        }
        _isOpen = YES;
    } else {
        [self.textView removeFromSuperview];
        for (NSLayoutConstraint *c in self.accordionView.constraints) {
            if (c.firstAttribute == NSLayoutAttributeHeight) {
                c.constant = 40;
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
                                                                   boldFontColor:@"#000000"
                                                                       fontColor:@"#000000"]];
        
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

@end
