//
//  GTPaymentCompletionViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 06/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTPaymentCompletionViewController.h"
#import "CTLabel.h"
#import "CTImageCache.h"
#import "CartrawlerSDK+NSDateUtils.h"

@interface GTPaymentCompletionViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *pickupLocationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *companyLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropoffLocationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *bookingRefLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropoffDateLabel;

@end

@implementation GTPaymentCompletionViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Disable iOS 7 back gesture
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSURL *selectedVehImg = self.groundSearch.selectedService.vehicleImage ?: self.groundSearch.selectedShuttle.vehicleImage;
    
    [[CTImageCache sharedInstance] cachedImage: selectedVehImg completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    self.pickupLocationLabel.text = self.groundSearch.pickupLocation.name;
    self.dropoffLocationLabel.text = self.groundSearch.dropoffLocation.name;
    NSString *companyDetails = self.groundSearch.selectedService.companyName ?: self.groundSearch.selectedShuttle.companyName;
    self.companyLabel.text = companyDetails;
    
    self.bookingRefLabel.text = [NSString stringWithFormat:@"Booking Reference: %@", self.groundSearch.booking.confirmationId];
    
    NSMutableAttributedString *dropoff = [[NSMutableAttributedString alloc] init];
    
    if (self.groundSearch.dropoffLocation.dateTime) {
        
        NSAttributedString *dropoffPrefix = [[NSAttributedString alloc] initWithString:@"Dropoff Date: "
                                                                            attributes:@{NSFontAttributeName:
                                                                                             [UIFont fontWithName:[CTAppearance instance].boldFontName size:20]}];
        
        NSAttributedString *dropoffSuffix = [[NSAttributedString alloc] initWithString:[self.groundSearch.dropoffLocation.dateTime stringFromDateWithFormat:@"dd/MM/yyyy hh:mm a"]
                                                                            attributes:@{NSFontAttributeName:
                                                                                             [UIFont fontWithName:[CTAppearance instance].fontName size:20]}];
        
        [dropoff appendAttributedString:dropoffPrefix];
        [dropoff appendAttributedString:dropoffSuffix];
        
    }
    
    NSAttributedString *pickupPrefix = [[NSAttributedString alloc] initWithString:@"Pickup Date: "
                                                                      attributes:@{NSFontAttributeName:
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName size:20]}];
    
    NSAttributedString *pickupSuffix = [[NSAttributedString alloc] initWithString:[self.groundSearch.pickupLocation.dateTime stringFromDateWithFormat:@"dd/MM/yyyy hh:mm a"]
                                                                       attributes:@{NSFontAttributeName:
                                                                                        [UIFont fontWithName:[CTAppearance instance].fontName size:20]}];
    
    NSMutableAttributedString *pickup = [[NSMutableAttributedString alloc] init];
    [pickup appendAttributedString:pickupPrefix];
    [pickup appendAttributedString:pickupSuffix];
    self.dateLabel.attributedText = pickup;
    self.dropoffDateLabel.attributedText = dropoff;

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

@end
