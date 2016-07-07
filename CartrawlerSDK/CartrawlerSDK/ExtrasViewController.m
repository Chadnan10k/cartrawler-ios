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

@interface ExtrasViewController () <UITextViewDelegate>

//@property (weak, nonatomic) IBOutlet UITextView *title;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *summaryHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *itemsTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemsHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *termsTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *termsHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *purchaseTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *purchaseHeightConstraint;


@property (weak, nonatomic) IBOutlet UILabel *item2Label;
@property (weak, nonatomic) IBOutlet UILabel *item3Label;

@property (weak, nonatomic) IBOutlet UIView *insuranceView;

@end

@implementation ExtrasViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.insuranceView.layer.cornerRadius = 3;
    self.insuranceView.layer.borderWidth = 1;
    self.insuranceView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.insuranceView.layer.masksToBounds = YES;
    
    NSDateComponents *pickupComp = [[NSDateComponents alloc] init];
    [pickupComp setDay:4];
    [pickupComp  setMonth:7];
    [pickupComp  setYear:2016];
    [pickupComp  setHour:13];
    [pickupComp  setMinute:30];
    [pickupComp  setSecond:00];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *pickupDate = [gregorian dateFromComponents:pickupComp];
    
    NSDateComponents * dropoffComp = [[NSDateComponents alloc] init];
    [dropoffComp setDay:6];
    [dropoffComp  setMonth:7];
    [dropoffComp  setYear:2016];
    [dropoffComp  setHour:13];
    [dropoffComp  setMinute:30];
    [dropoffComp  setSecond:00];
    
    NSDate *dropoffDate = [gregorian dateFromComponents: dropoffComp];
    
    [self setCartrawlerAPI:[[CartrawlerAPI alloc] initWithClientKey:@"463558" language:@"EN" debug:YES]];
    
    [self.cartrawlerAPI requestInsuranceQuoteForVehicle:@"IE"
                                               currency:@"EUR"
                                              totalCost:@"200.00"
                                         pickupDateTime:pickupDate
                                         returnDateTime:dropoffDate
                                 destinationCountryCode:@"ES"
                                             completion:^(CTInsurance *response, CTErrorResponse *error) {
                                                 if (response) {

                                                     dispatch_async(dispatch_get_main_queue(), ^{
                                                         [self setupView:response];
                                                     });
                                                     
                                                 } else {
                                                     NSLog(@"%@", error.errorMessage);
                                                 }
                                             }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
    [self.summaryTextView setContentOffset:CGPointZero animated:NO];
    [self.itemsTextView setContentOffset:CGPointZero animated:NO];
    [self.purchaseTextView setContentOffset:CGPointZero animated:NO];
}

- (void)setupView:(CTInsurance *)response
{
    self.summaryTextView.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                     pointSize:15
                                                                          text:response.summary
                                                                 boldFontColor:@"#3399ff"];
    self.summaryHeightConstraint.constant = self.summaryTextView.contentSize.height;
    
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
    
    self.itemsTextView.attributedText = listItems;

    
    NSDictionary *termsAttr = @{ NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                 NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName
                                                                       size:12]};
    
    self.termsTextView.attributedText = [[NSAttributedString alloc]
                                         initWithString:response.paragraphSubfooter attributes:termsAttr];
    
    NSDictionary *tcAttr = @{ NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:15] };
    
    NSMutableAttributedString *termsStr = [[NSMutableAttributedString alloc] initWithString:response.functionalText
                                                                                 attributes: tcAttr];
    
    
    NSDictionary *linkAttr = @{ NSLinkAttributeName : response.termsAndConditionsURL,
                                NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:15]
                                };
    
    NSAttributedString *termsLink = [[NSAttributedString alloc]
                                     initWithString:@"Terms and Conditions"
                                     attributes:linkAttr];
    
    NSRange range = [response.functionalText rangeOfString:@"${link1}"];
    
    
    [termsStr replaceCharactersInRange:range withAttributedString:termsLink];
    
    
    CGSize itemsTextViewSize = [self.itemsTextView sizeThatFits:CGSizeMake(self.itemsTextView.frame.size.width, FLT_MAX)];
    self.itemsHeightConstraint.constant = itemsTextViewSize.height;
    
    self.purchaseTextView.attributedText = termsStr;
    CGSize purchaseTextViewSize = [self.purchaseTextView sizeThatFits:CGSizeMake(self.purchaseTextView.frame.size.width, FLT_MAX)];
    self.purchaseHeightConstraint.constant = purchaseTextViewSize.height;
    
    CGSize termsTextViewSize = [self.termsTextView sizeThatFits:CGSizeMake(self.termsTextView.frame.size.width, FLT_MAX)];
    self.termsHeightConstraint.constant = termsTextViewSize.height;
    
    self.purchaseTextView.delegate = self;
    
    [self.view layoutIfNeeded];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    
    NSLog(@"Link tapped");
    return YES;
}

- (IBAction)addInsurance:(id)sender {
    
}

- (IBAction)continueNoInsurance:(id)sender {
    
}


@end
