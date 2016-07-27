//
//  ExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "ExtrasViewController.h"
#import "CTLabel.h"
#import "HTMLParser.h"
#import "CTAppearance.h"
#import "OptionalExtrasView.h"
#import "CTButton.h"
#import "CTTextView.h"
#import "CTPickerView.h"

@interface ExtrasViewController () <UITextViewDelegate, CTPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *insuranceView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceViewHeight;
@property (weak, nonatomic) IBOutlet OptionalExtrasView *optionalExtrasView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CTButton *continueButton;
@property (weak, nonatomic) IBOutlet CTButton *addInuranceButton;
@property (weak, nonatomic) IBOutlet CTButton *noInsuranceButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *insuranceViewSpace;

@property (strong, nonatomic) CTButton *itemSelectButton;
@property (strong, nonatomic) CTPickerView *pickerView;
@end

@implementation ExtrasViewController
{
    NSMutableArray <CTTextView *>*textViews;
    BOOL needsSelectedItem;
}

+ (void)forceLinkerLoad_
{
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    needsSelectedItem = NO;
    
    if (self.itemSelectButton) {
        [self.itemSelectButton removeFromSuperview];
    }
    
    for (CTTextView *textView in textViews) {
        [textView removeFromSuperview];
    }

    self.insuranceView.hidden = YES;
    
    [self.scrollView setContentOffset:
     CGPointMake(0, -self.scrollView.contentInset.top) animated:YES];
    
    self.insuranceView.layer.cornerRadius = 3;
    self.insuranceView.layer.borderWidth = 1;
    self.insuranceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.insuranceView.layer.masksToBounds = YES;
    
    if (self.selectedVehicle.extraEquipment.count > 0) {
        [self.optionalExtrasView hideView:NO];
        [self.optionalExtrasView setExtras:self.selectedVehicle.extraEquipment];
        [self.optionalExtrasView setInitialFrame:self.view.frame];
    } else {
        [self.optionalExtrasView hideView:YES];
    }
    
    [self setupView:self.insurance];
}

- (void)viewDidLayoutSubviews
{
    for (CTTextView *textView in textViews) {
        [textView setContentOffset:CGPointZero animated:NO];
    }
}

- (void)setupView:(CTInsurance *)response
{
    [self.view layoutIfNeeded];
    if (response)
    {
        [self.optionalExtrasView hideExpandbutton:NO];
        [self.optionalExtrasView close];
        
        self.insuranceView.hidden = NO;
        self.noInsuranceButton.hidden = NO;
        self.addInuranceButton.hidden = NO;
        
        self.continueButton.hidden = YES;
        self.insuranceViewSpace.constant = 8;
        
        self.insuranceView.translatesAutoresizingMaskIntoConstraints = false;

        textViews = [[NSMutableArray alloc] init];
        
        BOOL noResponse = YES;
        
        if (response.summary) {
            CTTextView *textView = [[CTTextView alloc] initWithFrame:CGRectZero];
            textView.delegate = self;
            textView.attributedText = [self summaryText:response];
            textView.selectable = YES;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.translatesAutoresizingMaskIntoConstraints = false;
            [textViews addObject:textView];
            [self.insuranceView addSubview:textView];
            noResponse = NO;
        }
        
        if (response.listItems) {
            CTTextView *textView = [[CTTextView alloc] initWithFrame:CGRectZero];
            textView.delegate = self;
            textView.attributedText = [self listItems:response];
            textView.selectable = YES;
            textView.editable = NO;
            textView.scrollEnabled = NO;
            textView.translatesAutoresizingMaskIntoConstraints = false;
            [textViews addObject:textView];
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
            [textViews addObject:textView];
            [self.insuranceView addSubview:textView];
            noResponse = NO;
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
            [textViews addObject:textView];
            [self.insuranceView addSubview:textView];
            noResponse = NO;
        }
        
        [self.view layoutIfNeeded];
        [self.insuranceView layoutIfNeeded];
        [self createTextViews:textViews container:self.insuranceView];
        
        if (response.selectorItems && response.selectorTitle) {
            [self createItemSelector:response];
            noResponse = NO;
        }
        
        if (noResponse) {
            [self.optionalExtrasView open:YES];
            self.insuranceViewHeight.constant = 20;
            self.continueButton.hidden = NO;
            self.insuranceViewSpace.constant = -20;
            self.insuranceView.hidden = YES;
            self.noInsuranceButton.hidden = YES;
            self.addInuranceButton.hidden = YES;
        }
        
    } else {
        [self.optionalExtrasView open:YES];
        self.insuranceViewHeight.constant = 20;
        self.continueButton.hidden = NO;
        self.insuranceViewSpace.constant = -20;
        self.insuranceView.hidden = YES;
        self.noInsuranceButton.hidden = YES;
        self.addInuranceButton.hidden = YES;
    }
}

- (void)createTextViews:(NSMutableArray <CTTextView *>*)viewArray container:(UIView *)container
{
    
    CGFloat containerHeight = 130;
    for (int i = 0; i < viewArray.count; ++i) {
        CGFloat height = [self textViewHeightForAttributedText:viewArray[i].attributedText andWidth:self.insuranceView.frame.size.width];

        if (i == 0) {
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:container
                                                                             attribute:NSLayoutAttributeTop
                                                                            multiplier:1.0
                                                                              constant:40];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:height];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:container
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            [container addConstraints:@[topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
            
            [self.insuranceView updateConstraints];
            
        } else {
            
            NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                             attribute:NSLayoutAttributeTop
                                                                             relatedBy:NSLayoutRelationEqual
                                                                                toItem:viewArray[i-1]
                                                                             attribute:NSLayoutAttributeBottom
                                                                            multiplier:1.0
                                                                              constant:5];
            
            NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                                attribute:NSLayoutAttributeHeight
                                                                                relatedBy:NSLayoutRelationEqual
                                                                                   toItem:nil
                                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                                               multiplier:1.0
                                                                                 constant:height];
            
            NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                              attribute:NSLayoutAttributeLeft
                                                                              relatedBy:NSLayoutRelationEqual
                                                                                 toItem:container
                                                                              attribute:NSLayoutAttributeLeft
                                                                             multiplier:1.0
                                                                               constant:5];
            
            NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:viewArray[i]
                                                                               attribute:NSLayoutAttributeRight
                                                                               relatedBy:NSLayoutRelationEqual
                                                                                  toItem:container
                                                                               attribute:NSLayoutAttributeRight
                                                                              multiplier:1.0
                                                                                constant:-5];
            [container addConstraints:@[topConstraint,
                                        leftConstraint,
                                        rightConstraint,
                                        heightConstraint]];
        }

        containerHeight += height;
        
    }
    
    //update container height
    self.insuranceViewHeight.constant = containerHeight;
}

- (void)createItemSelector:(CTInsurance *)insurance
{
    if (self.itemSelectButton) {
        [self.itemSelectButton removeFromSuperview];
    }
    
    _itemSelectButton = [[CTButton alloc] init];
    
    [self.itemSelectButton addTarget:self action:@selector(presentPicker:) forControlEvents:UIControlEventTouchUpInside];
    

    if (self.insuranceItem) {
        [self.itemSelectButton setTitle:self.insuranceItem.name forState:UIControlStateNormal];
    } else {
        [self.itemSelectButton setTitle:insurance.selectorTitle forState:UIControlStateNormal];
    }
    
    [self.insuranceView addSubview:self.itemSelectButton];
    self.itemSelectButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (textViews.count == 0) {
        //no insurance text, what do we do?
        return;
    }
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.itemSelectButton
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:textViews.lastObject
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
    
    needsSelectedItem = YES;
}

- (void)presentPicker:(id)sender
{
    if (!self.pickerView) {
        _pickerView = [[CTPickerView alloc] initWithFrame:CGRectZero];
        self.pickerView.pickerDelegate = self;
    }
    if (!self.pickerView.isVisible) {
        [self.pickerView presentInView:self.view data:self.insurance.selectorItems];
    } else {
        [self.pickerView removeFromView];
    }
}

- (CGFloat)textViewHeightForAttributedText:(NSAttributedString *)text andWidth:(CGFloat)width
{
    UITextView *textView = [[UITextView alloc] init];
    [textView setAttributedText:text];
    CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
    return size.height;
}

- (NSAttributedString *)scanForLinks:(NSAttributedString *)attrText response:(CTInsurance *)response
{
    for (InsuranceLink *link in response.links) {
        
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
            [[attrText mutableString] replaceOccurrencesOfString:@"{"
                                                      withString:@""
                                                         options:NSCaseInsensitiveSearch
                                                           range:NSMakeRange(0, attrText.string.length)];
            [[attrText mutableString] replaceOccurrencesOfString:@"}"
                                                      withString:@""
                                                         options:NSCaseInsensitiveSearch
                                                           range:NSMakeRange(0, attrText.string.length)];

            return attrText;
        } else {
            return attrText;
        }
    }
    return attrText;
}

- (NSAttributedString *)termsAndConditionsLink:(CTInsurance *)response
{
    return [self scanForLinks:[[NSAttributedString alloc]
                               initWithString:response.functionalText]
                                response:response];
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
                                                                       size:15]};
    return [self scanForLinks:[[NSAttributedString alloc] initWithString:response.paragraphSubfooter
                                                              attributes:termsAttr]
                     response:response];
    
}

- (NSAttributedString *)listItems:(CTInsurance *)response
{
    NSMutableAttributedString *listItems = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < response.listItems.count; ++i) {
        [listItems appendAttributedString:[HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                     pointSize:15
                                                                          text:response.listItems[i]
                                                                 boldFontColor:@"#3399ff"]];
        
        if (i != response.listItems.count-1) {
            [listItems appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
        }
    }
    
    return [self scanForLinks:listItems response:response];
}

- (NSAttributedString *)summaryText:(CTInsurance *)response
{
    NSAttributedString *htmlText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                    pointSize:15
                                                         text:response.summary
                                                boldFontColor:@"#3399ff"];
    
    return [self scanForLinks:htmlText response:response];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    NSLog(@"Link tapped");
    return YES;
}

- (IBAction)addInsurance:(id)sender
{
    if (needsSelectedItem && !self.insuranceItem) {
        [self.itemSelectButton shake];
        return;
    }
    
    [self pushToStepFive:self.selectedVehicle.extraEquipment insuranceSelected:YES];
}

- (IBAction)continueNoInsurance:(id)sender
{
    [self pushToStepFive:self.selectedVehicle.extraEquipment insuranceSelected:NO];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)pickerViewDidSelectItem:(InsuranceSelectorItem *)item
{
    [self setInsuranceItem:item];
    [self.itemSelectButton setTitle:item.name forState:UIControlStateNormal];
}

@end
