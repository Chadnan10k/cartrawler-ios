//
//  BookingSummaryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "BookingSummaryViewController.h"
#import <CartrawlerAPI/CTVendor.h>
#import "DateUtils.h"
#import "CTButton.h"
#import "CTLabel.h"
#import "CTAppearance.h"

@interface BookingSummaryViewController ()
@property (weak, nonatomic) IBOutlet CTLabel *carModelLabel;
@property (weak, nonatomic) IBOutlet CTLabel *vendorNameLabel;
@property (weak, nonatomic) IBOutlet CTLabel *vendorRatingLabel;
@property (weak, nonatomic) IBOutlet CTLabel *pickupDateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropOffDateLabel;
@property (weak, nonatomic) IBOutlet CTButton *insuranceButton;

@property (strong, nonatomic) CTVehicle *vehicle;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *dropoffDate;
@property (nonatomic) BOOL isBuyingInsurance;

@end

@implementation BookingSummaryViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view.
    NSString *score = [NSString stringWithFormat:@"%.1f", self.vehicle.vendor.rating.overallScore.floatValue * 2];

    NSAttributedString *rating = [[NSAttributedString alloc] initWithString:score
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:16],
                                                                               NSForegroundColorAttributeName : [CTAppearance instance].textFieldTint}];
    
    NSAttributedString *slash = [[NSAttributedString alloc] initWithString:@" / "
                                                              attributes:@{NSFontAttributeName:
                                                                               [UIFont fontWithName:[CTAppearance instance].fontName size:12],
                                                                           NSForegroundColorAttributeName : [CTAppearance instance].textFieldTint}];
    
    NSAttributedString *ten = [[NSAttributedString alloc] initWithString:@"10"
                                                                attributes:@{NSFontAttributeName:
                                                                                 [UIFont fontWithName:[CTAppearance instance].fontName size:12], NSForegroundColorAttributeName : [CTAppearance instance].textFieldTint}];
    
    
    NSMutableAttributedString *ratingStr = [[NSMutableAttributedString alloc] init];
    
    [ratingStr appendAttributedString:rating];
    [ratingStr appendAttributedString:slash];
    [ratingStr appendAttributedString:ten];
    
    self.vendorRatingLabel.attributedText = ratingStr;

    self.carModelLabel.text = self.vehicle.makeModelName;
    self.vendorNameLabel.text = self.vehicle.vendor.name;
    self.pickupDateLabel.text = [DateUtils stringFromDate:self.pickupDate withFormat:@"hh:mm a dd MMMM YYYY"];
    self.dropOffDateLabel.text = [DateUtils stringFromDate:self.dropoffDate withFormat:@"hh:mm a dd MMMM YYYY"];
 
    if (self.isBuyingInsurance) {
        [self.insuranceButton setTitleColor:[UIColor colorWithRed:97.0/255.0 green:163.0/255.0 blue:59.0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.insuranceButton setTitle:NSLocalizedString(@"Protected", @"Protected") forState:UIControlStateNormal];
        self.insuranceButton.enabled = NO;
    } else {
        [self.insuranceButton setTitleColor:[UIColor colorWithRed:186.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1] forState:UIControlStateNormal];
        [self.insuranceButton setTitle:NSLocalizedString(@"Warning! Not protected", @"Warning! Not protected") forState:UIControlStateNormal];
    }
    
}

- (void)setDataWithVehicle:(CTVehicle *)vehicle
                pickupDate:(NSDate *)pickupDate
               dropoffDate:(NSDate *)dropoffDate
         isBuyingInsurance:(BOOL)isBuyingInsurance
{
    _vehicle = vehicle;
    _pickupDate = pickupDate;
    _dropoffDate = dropoffDate;
    _isBuyingInsurance = isBuyingInsurance;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
