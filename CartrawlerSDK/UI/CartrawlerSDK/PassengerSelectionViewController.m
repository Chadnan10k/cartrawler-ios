//
//  PassengerSelectionViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 26/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PassengerSelectionViewController.h"
#import "CTLabel.h"
#import "CTStepper.h"

@interface PassengerSelectionViewController ()

@property (weak, nonatomic) IBOutlet CTLabel *adultsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *childrenLabel;
@property (weak, nonatomic) IBOutlet CTLabel *infantsLabel;
@property (weak, nonatomic) IBOutlet CTLabel *seniorsLabel;
@property (weak, nonatomic) IBOutlet CTStepper *adultStepper;
@property (weak, nonatomic) IBOutlet CTStepper *childStepper;
@property (weak, nonatomic) IBOutlet CTStepper *infantStepper;
@property (weak, nonatomic) IBOutlet CTStepper *seniorStepper;

@property (weak, nonatomic) IBOutlet CTLabel *adultCountLabel;
@property (weak, nonatomic) IBOutlet CTLabel *childrenCountLabel;
@property (weak, nonatomic) IBOutlet CTLabel *infantsCountLabel;
@property (weak, nonatomic) IBOutlet CTLabel *seniorsCountLabel;

@end

@implementation PassengerSelectionViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.adultCountLabel.text = [NSString stringWithFormat:@"%d", self.groundSearch.adultQty.intValue];
    self.childrenCountLabel.text = [NSString stringWithFormat:@"%d", self.groundSearch.childQty.intValue];
    self.infantsCountLabel.text = [NSString stringWithFormat:@"%d", self.groundSearch.infantQty.intValue];
    self.seniorsCountLabel.text = [NSString stringWithFormat:@"%d", self.groundSearch.seniorQty.intValue];
    
    self.adultStepper.value = self.groundSearch.adultQty.doubleValue;
    self.childStepper.value = self.groundSearch.childQty.doubleValue;
    self.infantStepper.value = self.groundSearch.infantQty.doubleValue;
    self.seniorStepper.value = self.groundSearch.seniorQty.doubleValue;    
}

- (IBAction)close:(id)sender {
    [self produceText];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)adultsChanged:(id)sender
{
    UIStepper *stepper = sender;
    [self shakeAnimation:self.adultsLabel];
    self.adultCountLabel.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    self.groundSearch.adultQty = [NSNumber numberWithDouble:stepper.value];
}

- (IBAction)childrenChanged:(id)sender
{
    UIStepper *stepper = sender;
    [self shakeAnimation:self.childrenLabel];
    self.childrenCountLabel.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    self.groundSearch.childQty = [NSNumber numberWithDouble:stepper.value];
}

- (IBAction)infantsChanged:(id)sender
{
    UIStepper *stepper = sender;
    [self shakeAnimation:self.infantsLabel];
    self.infantsCountLabel.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    self.groundSearch.infantQty = [NSNumber numberWithDouble:stepper.value];
}

- (IBAction)seniorsChanged:(id)sender
{
    UIStepper *stepper = sender;
    [self shakeAnimation:self.seniorsLabel];
    self.seniorsCountLabel.text = [NSString stringWithFormat:@"%.0f", stepper.value];
    self.groundSearch.seniorQty = [NSNumber numberWithDouble:stepper.value];
}


- (void)shakeAnimation:(CTLabel *)label
{
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:0 animations:^{
        label.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.4 animations:^{
            label.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }];
}

- (void)produceText
{
    NSMutableString *passengers = [[NSMutableString alloc] init];
    
    if (self.groundSearch.adultQty.intValue > 0) {
        [passengers appendString:[NSString stringWithFormat:@"Adults (%d) ", self.groundSearch.adultQty.intValue]];
    }
    
    if (self.groundSearch.childQty.intValue > 0) {
        [passengers appendString:[NSString stringWithFormat:@"Children (%d) ", self.groundSearch.childQty.intValue]];
    }
    
    if (self.groundSearch.infantQty.intValue > 0) {
        [passengers appendString:[NSString stringWithFormat:@"Infants (%d) ", self.groundSearch.infantQty.intValue]];
    }
    
    if (self.groundSearch.seniorQty.intValue > 0) {
        [passengers appendString:[NSString stringWithFormat:@"Seniors (%d) ", self.groundSearch.seniorQty.intValue]];
    }
    
    if (self.updatedData) {
        self.updatedData(passengers);
    }
}


@end
