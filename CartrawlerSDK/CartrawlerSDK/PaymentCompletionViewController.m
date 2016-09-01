//
//  PaymentCompletionViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 08/08/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "PaymentCompletionViewController.h"
#import "CTLabel.h"
#import "CTSearch.h"
#import "CTImageCache.h"
#import "CTAppearance.h"
#import "NSDateUtils.h"

@interface PaymentCompletionViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet CTLabel *paymentTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImage;
@property (weak, nonatomic) IBOutlet CTLabel *vehicleName;
@property (weak, nonatomic) IBOutlet CTLabel *pickupLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropoffLabel;
@property (weak, nonatomic) IBOutlet CTLabel *supplierLabel;
@property (weak, nonatomic) IBOutlet UIImageView *supplierImage;

@end

@implementation PaymentCompletionViewController

+(void)forceLinkerLoad_ { }

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Disable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[CTImageCache sharedInstance] cachedImage: [CTSearch instance].selectedVehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImage.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: [CTSearch instance].selectedVehicle.vendor.logoURL completion:^(UIImage *image) {
        self.supplierImage.image = image;
    }];
    
    self.supplierLabel.text = [CTSearch instance].selectedVehicle.vendor.name;
    
    self.vehicleName.text = [CTSearch instance].selectedVehicle.makeModelName;
    
    NSAttributedString *pickupLoc = [[NSAttributedString alloc] initWithString:[CTSearch instance].pickupLocation.name
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].boldFontName size:16]}];
    
    NSAttributedString *pickupDate = [[NSAttributedString alloc] initWithString:[NSDateUtils stringFromDateWithFormat:[CTSearch instance].pickupDate
                                                                                                               format:@"EEE, MMM YYYY, hh:mm a"]
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].fontName size:16]}];
    
    NSMutableAttributedString *pickup = [[NSMutableAttributedString alloc] init];
    [pickup appendAttributedString:pickupLoc];
    [pickup appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n "]];
    [pickup appendAttributedString:pickupDate];
    
    NSAttributedString *dropoffLoc = [[NSAttributedString alloc] initWithString:[CTSearch instance].dropoffLocation.name
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].boldFontName size:16]}];
    
    NSAttributedString *dropoffDate = [[NSAttributedString alloc] initWithString:[NSDateUtils stringFromDateWithFormat:[CTSearch instance].dropoffDate
                                                                                                               format:@"EEE, MMM YYYY, hh:mm a"]
                                                                     attributes:@{NSFontAttributeName:
                                                                                      [UIFont fontWithName:[CTAppearance instance].fontName size:16]}];
    
    NSMutableAttributedString *dropoff = [[NSMutableAttributedString alloc] init];
    [dropoff appendAttributedString:dropoffLoc];
    [dropoff appendAttributedString:[[NSAttributedString alloc] initWithString:@" \n "]];
    [dropoff appendAttributedString:dropoffDate];
    
    self.pickupLabel.attributedText = pickup;
    self.dropoffLabel.attributedText = dropoff;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)done:(id)sender {
    [[CTImageCache sharedInstance] removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end