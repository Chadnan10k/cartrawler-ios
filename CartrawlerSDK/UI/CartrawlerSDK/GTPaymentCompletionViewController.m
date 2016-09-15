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
#import "NSDateUtils.h"

@interface GTPaymentCompletionViewController () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *companyLabel;

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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *selectedVehImg = self.groundSearch.selectedService.vehicleImage ?: self.groundSearch.selectedShuttle.vehicleImage;
    
    [[CTImageCache sharedInstance] cachedImage: selectedVehImg completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    NSString *returnDate = self.groundSearch.dropoffLocation.dateTime ? [NSString stringWithFormat:@"\nReturn date: %@", [NSDateUtils stringFromDateWithFormat:self.groundSearch.dropoffLocation.dateTime format:@"dd/MM/yyyy hh:mm a"]] : @"";
    
    NSString *locationDetails = [NSString stringWithFormat:@"Pickup: %@ \n\n%@ \n\nDropoff: %@\n%@",
                                 self.groundSearch.pickupLocation.name,
                                 [NSDateUtils stringFromDateWithFormat:self.groundSearch.pickupLocation.dateTime format:@"dd/MM/yyyy hh:mm a"],
                                 self.groundSearch.dropoffLocation.name, returnDate];
    
    self.locationLabel.text = locationDetails;
    
    NSString *companyDetails = self.groundSearch.selectedService.companyName ?: self.groundSearch.selectedShuttle.companyName;
    self.companyLabel.text = companyDetails;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return NO;
}

@end
