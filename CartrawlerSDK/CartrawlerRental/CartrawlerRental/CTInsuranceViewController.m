//
//  CTExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInsuranceViewController.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTHTMLParser.h>
#import <CartrawlerSDK/CTAppearance.h>
#import "CTOptionalExtrasView.h"
#import <CartrawlerSDK/CTButton.h>
#import <CartrawlerSDK/CTTextView.h>
#import <CartrawlerSDK/CTPickerView.h>
#import <CartrawlerSDK/CTImageCache.h>
#import <CartrawlerSDK/CartrawlerSDK+UIColor.h>
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import "CTOptionalExtrasViewController.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTInsuranceViewController () <UITextViewDelegate, CTPickerViewDelegate, OptionalExtrasDelegate>

@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *insuranceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceViewHeight;
@property (weak, nonatomic) IBOutlet CTOptionalExtrasView *optionalExtrasView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet CTLabel *extrasTitleLabel;
@property (weak, nonatomic) IBOutlet CTLabel *insuranceTitleLabel;

@property (weak, nonatomic) IBOutlet CTButton *continueButton;
@property (weak, nonatomic) IBOutlet CTButton *addInuranceButton;
@property (weak, nonatomic) IBOutlet CTButton *noInsuranceButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceViewSpace;

@property (strong, nonatomic) CTButton *itemSelectButton;
@property (strong, nonatomic) CTPickerView *pickerView;

@property (strong, nonatomic) NSMutableArray <NSDictionary *>*textViews;
@property (strong, nonatomic) UIView *imageContainer;
@property (assign, nonatomic) BOOL needsSelectedItem;
@property (weak, nonatomic) IBOutlet CTLabel *pricePerDayLabel;

@end

@implementation CTInsuranceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.optionalExtrasView.delegate = self;
    self.titleLabel.text = CTLocalizedString(CTRentalTitleExtrasInsurace);
    self.extrasTitleLabel.text = CTLocalizedString(CTRentalTitleExtras);
    self.insuranceTitleLabel.text = CTLocalizedString(CTRentalTitleInsurance);
    [self.addInuranceButton setTitle:CTLocalizedString(CTRentalCTAWithInsurance) forState:UIControlStateNormal];
    [self.noInsuranceButton setTitle:CTLocalizedString(CTRentalCTANoInsurance) forState:UIControlStateNormal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self tagScreen];

    self.needsSelectedItem = NO;
    
    if (self.itemSelectButton) {
        [self.itemSelectButton removeFromSuperview];
    }
    
    for (NSDictionary *textViewDict in self.textViews) {
        [[textViewDict objectForKey:@"view"] removeFromSuperview];
    }
    
    if (self.imageContainer) {
        [self.imageContainer removeFromSuperview];
    }

    self.insuranceView.hidden = YES;
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    [self setupView:self.search.insurance];
    
    if (self.search.selectedVehicle.vehicle.extraEquipment.count > 0) {
        self.optionalExtrasView.extras = self.search.selectedVehicle.vehicle.extraEquipment;
        [self.optionalExtrasView hideView:NO];
    } else {
        [self.optionalExtrasView hideView:YES];
    }

}

- (void)setPricePerDay
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorianCalendar components:NSCalendarUnitDay
                                                        fromDate:self.search.pickupDate
                                                          toDate:self.search.dropoffDate
                                                         options:0];

    self.pricePerDayLabel.text = [NSString stringWithFormat:@"%@ %@",
                                  [[NSNumber numberWithFloat:self.search.insurance.premiumAmount.floatValue / ([components day] ?: 1)] numberStringWithCurrencyCode], CTLocalizedString(CTRentalExtrasPerDay)];
}

- (void)viewDidLayoutSubviews
{
    for (NSDictionary *textViewDict in self.textViews) {
        if ([[textViewDict objectForKey:@"view"] isKindOfClass:[CTTextView class]]) {
            [[textViewDict objectForKey:@"view"] setContentOffset:CGPointZero animated:NO];
        }
    }
}

- (void)setupView:(CTInsurance *)response
{
    [self.view layoutIfNeeded];
    if (response)
    {
        
        [self setPricePerDay];
        
        self.insuranceView.hidden = NO;
        self.noInsuranceButton.hidden = NO;
        self.addInuranceButton.hidden = NO;
        
        self.continueButton.hidden = YES;
        self.insuranceViewSpace.constant = 8;
        
        self.insuranceView.translatesAutoresizingMaskIntoConstraints = false;

        self.textViews = [[NSMutableArray alloc] init];
        
        BOOL noResponse = YES;
        
        if (response.summary) {
            CTTextView *textView = [[CTTextView alloc] initWithFrame:CGRectZero];
            textView.delegate = self;
            textView.attributedText = [self summaryText:response];
            textView.selectable = YES;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.translatesAutoresizingMaskIntoConstraints = false;
            [self pushTextViewToArray:textView];
            [self.insuranceView addSubview:textView];
            noResponse = NO;
        }
        
        _imageContainer = [self insuranceImagePlaceholder:response];
        [self.insuranceView addSubview:self.imageContainer];
        [self.textViews addObject:@{ @"view" : self.imageContainer, @"height" : @60.0 }];
        
        if (response.listItems) {
            
            UIView *listContainer = [UIView new];
            listContainer.backgroundColor = [CTAppearance instance].insurancePrimaryColor;
            listContainer.translatesAutoresizingMaskIntoConstraints = NO;
            [self.insuranceView addSubview:listContainer];
            
            UIImageView *shieldImageView = [UIImageView new];
            shieldImageView.alpha = 0.8;
            shieldImageView.translatesAutoresizingMaskIntoConstraints = NO;
            shieldImageView.contentMode = UIViewContentModeScaleAspectFit;
            NSBundle *b = [NSBundle bundleForClass:[self class]];
            UIImage *shield = [UIImage imageNamed:@"insurance_shield" inBundle:b compatibleWithTraitCollection:nil];
            shieldImageView.image = shield;
            [listContainer addSubview:shieldImageView];
            
            CTTextView *textView = [[CTTextView alloc] initWithFrame:CGRectZero];
            textView.backgroundColor = [UIColor clearColor];
            textView.delegate = self;
            textView.attributedText = [self listItems:response];
            textView.selectable = YES;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.translatesAutoresizingMaskIntoConstraints = false;
            noResponse = NO;
            [listContainer addSubview:textView];

            CTLabel *listContainerTitle = [CTLabel new];
            listContainerTitle.textColor = [UIColor whiteColor];
            listContainerTitle.textAlignment = NSTextAlignmentCenter;
            listContainerTitle.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:21];
            listContainerTitle.translatesAutoresizingMaskIntoConstraints = NO;
            listContainerTitle.text = CTLocalizedString(CTRentalInsuranceSummaryTitle);
            [listContainer addSubview:listContainerTitle];
        
            
            //title
            [listContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view]"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"view" : listContainerTitle}]];
            
            [listContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"view" : listContainerTitle}]];
            
            //textview
            [listContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title]-8-[view]-8-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                    views:@{@"view" : textView, @"title" : listContainerTitle}]];
            
            [listContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view]-8-|"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:@{@"view" : textView}]];
            
            //shield
            [listContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[title]-32-[view]-32-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"view" : shieldImageView, @"title" : listContainerTitle}]];
            
            [listContainer addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-32-[view]-32-|"
                                                                                  options:0
                                                                                  metrics:nil
                                                                                    views:@{@"view" : shieldImageView}]];
            
            [self.textViews addObject:@{ @"view" : listContainer, @"height" : @0, @"disablePadding" : @YES}];

        }

        if (response.termsAndConditionsURL && response.functionalText && response.termsAndConditionsTitle) {
            CTTextView *textView = [[CTTextView alloc] initWithFrame:CGRectZero];
            textView.delegate = self;
            textView.attributedText = [self termsAndConditionsLink:response];
            textView.selectable = YES;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.dataDetectorTypes = UIDataDetectorTypeLink;
            textView.translatesAutoresizingMaskIntoConstraints = false;
            [self pushTextViewToArray:textView];
            [self.insuranceView addSubview:textView];
            noResponse = NO;
        }
        
        if (response.paragraphSubfooter) {
            CTTextView *textView = [[CTTextView alloc] initWithFrame:CGRectZero];
            textView.delegate = self;
            textView.attributedText = [self termsAndConditionsText:response];
            textView.selectable = YES;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.translatesAutoresizingMaskIntoConstraints = false;
            [self pushTextViewToArray:textView];
            [self.insuranceView addSubview:textView];
            noResponse = NO;
        }
        
        [self.view layoutIfNeeded];
        [self.insuranceView layoutIfNeeded];
        [self createTextViews:self.textViews container:self.insuranceView response:response];
        
        if (response.selectorItems && response.selectorTitle) {
            [self createItemSelector:response];
            noResponse = NO;
        }
        
        if (noResponse) {
            self.insuranceViewHeight.constant = 8;
            self.continueButton.hidden = NO;
            self.insuranceViewSpace.constant = -8;
            self.insuranceView.hidden = YES;
            self.noInsuranceButton.hidden = YES;
            self.addInuranceButton.hidden = YES;
        }
        
    } else {
        self.insuranceViewHeight.constant = 8;
        self.continueButton.hidden = NO;
        self.insuranceViewSpace.constant = -8;
        self.insuranceView.hidden = YES;
        self.noInsuranceButton.hidden = YES;
        self.addInuranceButton.hidden = YES;
    }
}

- (void)pushTextViewToArray:(CTTextView *)textView
{
    CGFloat height = [self textViewHeightForAttributedText:textView.attributedText andWidth:self.insuranceView.frame.size.width];
    [self.textViews addObject:@{ @"view" : textView, @"height" : [NSNumber numberWithFloat:height] }];
}

- (void)createTextViews:(NSMutableArray <NSDictionary *>*)viewArray container:(UIView *)container response:(CTInsurance *)response
{
    for (int i = 0; i < viewArray.count; i++) {
        
        NSString *format = @"";
        NSString *hFormat = @"H:|-8-[view]-8-|";

        NSDictionary *metrics = @{ @"height" : [viewArray[i] objectForKey:@"height"] };
        NSDictionary *views = @{ @"view" : [viewArray[i] objectForKey:@"view"] };
        if (i == 0) {
            format = @"V:|-40-[view(height)]";
        } else if (i == viewArray.count-1) {
            views = @{ @"view" : [viewArray[i] objectForKey:@"view"], @"topView" : [viewArray[i-1] objectForKey:@"view"]};
            format = @"V:[topView]-8-[view(height)]-16-|";
        } else {
            views = @{ @"view" : [viewArray[i] objectForKey:@"view"], @"topView" : [viewArray[i-1] objectForKey:@"view"]};
            format = @"V:[topView]-8-[view(height)]";
        }
        
        if ([viewArray[i] objectForKey:@"disablePadding"]) {
            hFormat = @"H:|-0-[view]-0-|";
            format = @"V:[topView]-8-[view]";
        }

        [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:views]];
        
        [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:hFormat
                                                                          options:0
                                                                          metrics:metrics
                                                                            views:views]];
    }
}

- (void)createItemSelector:(CTInsurance *)insurance
{
    /*
    if (self.itemSelectButton) {
        [self.itemSelectButton removeFromSuperview];
    }
    
    _itemSelectButton = [[CTButton alloc] init];
    
    [self.itemSelectButton addTarget:self action:@selector(presentPicker:) forControlEvents:UIControlEventTouchUpInside];
    

    if (self.search.insuranceItem) {
        [self.itemSelectButton setTitle:self.search.insuranceItem.name forState:UIControlStateNormal];
    } else {
        [self.itemSelectButton setTitle:self.search.insurance.selectorTitle forState:UIControlStateNormal];
    }
    
    [self.insuranceView addSubview:self.itemSelectButton];
    self.itemSelectButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.textViews.count == 0) {
        //no insurance text, what do we do?
        return;
    }
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.itemSelectButton
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.textViews.lastObject
                                                                     attribute:NSLayoutAttributeBottom
                                                                    multiplier:1.0
                                                                      constant:10];

    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.itemSelectButton
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:nil
                                                                        attribute:NSLayoutAttributeNotAnAttribute
                                                                       multiplier:1.0
                                                                         constant:60];

    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.itemSelectButton
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.insuranceView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0
                                                                       constant:8];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.itemSelectButton
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.insuranceView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0
                                                                        constant:-8];
    [self.insuranceView addConstraints:@[topConstraint,
                                leftConstraint,
                                rightConstraint,
                                heightConstraint]];
    
    self.insuranceViewHeight.constant = self.insuranceViewHeight.constant + 70;
    
    self.needsSelectedItem = YES;
     */
}

- (void)presentPicker:(id)sender
{
    if (!self.pickerView) {
        _pickerView = [[CTPickerView alloc] initWithFrame:CGRectZero];
        self.pickerView.pickerDelegate = self;
    }
    if (!self.pickerView.isVisible) {
        [self.pickerView presentInView:self.view data:self.search.insurance.selectorItems];
    } else {
        [self.pickerView removeFromView];
    }
}

- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    textView.attributedText = text;
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
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

- (NSAttributedString *)termsAndConditionsLink:(CTInsurance *)response
{
    NSDictionary *termsAttr = @{NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName
                                                                       size:15]};
    
    if (response.paragraphFooter) {
        return [self scanForLinks:[[NSAttributedString alloc] initWithString:response.paragraphFooter
                                                                  attributes:termsAttr]
                         response:response];
    } else {
            return [self scanForLinks:[[NSAttributedString alloc] initWithString:response.functionalText
                                                                  attributes:termsAttr]
                         response:response];
    }
}

- (NSAttributedString *)functionalText:(CTInsurance *)response
{
    NSDictionary *tcAttr = @{ NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:15] };
    
    return [self scanForLinks:[[NSMutableAttributedString alloc] initWithString:response.functionalText attributes: tcAttr]
                     response:response];
}

- (NSAttributedString *)termsAndConditionsText:(CTInsurance *)response
{
    NSDictionary *termsAttr = @{ NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName
                                                                       size:11]};
    return [self scanForLinks:[[NSAttributedString alloc] initWithString:response.paragraphSubfooter
                                                              attributes:termsAttr]
                     response:response];
    
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

- (NSAttributedString *)summaryText:(CTInsurance *)response
{
    NSAttributedString *htmlText = [CTHTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                              pointSize:15
                                                                   text:response.summary
                                                          boldFontColor:[[CTAppearance instance].insurancePrimaryColor hex]
                                                              fontColor:@"#000000"];
    
    return [self scanForLinks:htmlText response:response];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
}

- (UIView *)insuranceImagePlaceholder:(CTInsurance *)response
{
    UIView *placeholder = [UIView new];
    placeholder.translatesAutoresizingMaskIntoConstraints = NO;
    placeholder.backgroundColor = [UIColor groupTableViewBackgroundColor];
    placeholder.layer.cornerRadius = [CTAppearance instance].buttonCornerRadius;
    
    UIImageView *insurerImageView = [UIImageView new];
    insurerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    insurerImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (response.imageURL) {
        [[CTImageCache sharedInstance] cachedImage: response.imageURL completion:^(UIImage *image) {
            insurerImageView.image = image;
        }];
    }
    
    [placeholder addSubview:insurerImageView];
    
    [placeholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[view]-8-|"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"view" : insurerImageView}]];
    
    [placeholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-8-[view(100)]"
                                                                        options:0
                                                                        metrics:nil
                                                                          views:@{@"view" : insurerImageView}]];
    
    CTLabel *insurerTitle = [CTLabel new];
    insurerTitle.textColor = [UIColor blackColor];
    insurerTitle.textAlignment = NSTextAlignmentCenter;
    insurerTitle.font = [UIFont fontWithName:[CTAppearance instance].fontName size:12];
    insurerTitle.translatesAutoresizingMaskIntoConstraints = NO;
    insurerTitle.text = CTLocalizedString(CTRentalExtrasPlaceholder);
    insurerTitle.numberOfLines = 0;
    [placeholder addSubview:insurerTitle];
    
    [placeholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[view]-4-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"view" : insurerTitle}]];
    
    [placeholder addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[image]-4-[view]-4-|"
                                                                                options:0
                                                                                metrics:nil
                                                                                  views:@{@"image" : insurerImageView, @"view" : insurerTitle}]];
    
    return placeholder;
}

- (IBAction)addInsurance:(id)sender
{
    [[CTAnalytics instance] tagScreen:@"ins_click" detail:@"1" step:@4];
    if (self.needsSelectedItem && !self.search.insuranceItem) {
        [self.itemSelectButton shake];
        return;
    }
    [self.search setIsBuyingInsurance:YES];
    [self pushToDestination];
}

- (IBAction)continueNoInsurance:(id)sender
{
    [[CTAnalytics instance] tagScreen:@"ins_click" detail:@"0" step:@4];
    [self.search setIsBuyingInsurance:NO];
    [self pushToDestination];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pickerViewDidSelectItem:(CTInsuranceSelectorItem *)item
{
    (self.search).insuranceItem = item;
    [self.itemSelectButton setTitle:item.name forState:UIControlStateNormal];
}

#pragma mark OptionalExtrasDelegate

- (void)pushToExtrasView
{
    [self.navigationController pushViewController:self.optionalRoute animated:YES];
}

#pragma mark Analytics

- (void)tagScreen
{
    [[CTAnalytics instance] tagScreen:@"step" detail:@"vehicles-e" step:@4];
    [[CTAnalytics instance] tagScreen:@"ins_offer" detail:@"yes" step:@4];
    [self sendEvent:NO customParams:@{@"eventName" : @"Insurance & Extras Step",
                                      @"stepName" : @"Step4",
                                      @"insuranceOffered" : @"true"
                                      } eventName:@"Step of search" eventType:@"Step"];
}

@end
