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

@interface ExtrasViewController ()

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

@end

@implementation ExtrasViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
                                                         
                                                         self.summaryTextView.attributedText = [HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                                                                          pointSize:15
                                                                                                                               text:response.summary];
                                                         self.summaryHeightConstraint.constant = self.summaryTextView.contentSize.height;
                                                         
                                                         NSMutableAttributedString *listItems = [[NSMutableAttributedString alloc] init];
                                                         
                                                         for (NSString *str in response.listItems) {
                                                             [listItems appendAttributedString:[HTMLParser htmlStringWithFontFamily:[CTAppearance instance].fontName
                                                                                                                          pointSize:15
                                                                                                                               text:str]];
                                                             [listItems appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
                                                         }

                                                         self.itemsTextView.attributedText = listItems;
                                                         self.itemsHeightConstraint.constant = self.itemsTextView.contentSize.height;
                                                         
                                                         NSDictionary *termsAttr = @{ NSForegroundColorAttributeName : [UIColor lightGrayColor],
                                                                                      NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName
                                                                                                                            size:10]};
                                                         
                                                         self.termsTextView.attributedText = [[NSAttributedString alloc]
                                                                                              initWithString:response.paragraphSubfooter attributes:termsAttr];
                                                         
                                                         NSMutableAttributedString *termsStr = [[NSMutableAttributedString alloc] initWithString:
                                                                                                response.functionalText];
                                                         NSString *linkStr = @"${link1}{}";
                                                         
                                                         [[termsStr mutableString] replaceOccurrencesOfString:linkStr withString:@""
                                                                                                    options:0
                                                                                                      range:NSMakeRange(0, termsStr.string.length)];

                                                         
                                                         
                                                         NSLog(@"%@", termsStr);
                                                         [self.view layoutIfNeeded];
                                                         
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
