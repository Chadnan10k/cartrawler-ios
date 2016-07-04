//
//  VehicleDetailsView.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 04/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "VehicleDetailsView.h"
#import "CTImageCache.h"
#import "IncludedCollectionViewCell.h"

@interface VehicleDetailsView() <UICollectionViewDataSource>

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *vehicleNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *passengersLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *doorsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *bagsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *transmissionLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *vendorRatingLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *includedCollectionView;
@property (strong, nonatomic) NSArray<NSString *> *collectionViewData;
@property (strong, nonatomic) CTVehicle *vehicle;
@property (strong, nonatomic) CartrawlerAPI *api;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *returnDate;
@property (strong, nonatomic) NSString *pickupCode;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *homeCountry;

@end

@implementation VehicleDetailsView

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[CTImageCache sharedInstance] cachedImage: self.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: self.vehicle.vendor.venLogo completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    self.includedCollectionView.dataSource = self;
    
    self.vehicleNameLabel.text = self.vehicle.vehicleMakeModelName;
    self.passengersLabel.text = [NSString stringWithFormat:@"%@ %@", self.vehicle.passengerQty.stringValue, NSLocalizedString(@"passengers", @"passengers")];
    self.doorsLabel.text = [NSString stringWithFormat:@"%@ %@", self.vehicle.doorCount.stringValue, NSLocalizedString(@"doors", @"doors")];
    self.bagsLabel.text = [NSString stringWithFormat:@"%@ %@", self.vehicle.baggageQty.stringValue, NSLocalizedString(@"bags", @"bags")];
    self.transmissionLabel.text = self.vehicle.transmissionType;
}

- (void)setData:(CTVehicle *)vehicle
            api:(CartrawlerAPI *)api
     pickupDate:(NSDate *)pickupDate
     returnDate:(NSDate *)returnDate
     pickupCode:(NSString *)pickupCode
     returnCode:(NSString *)returnCode
    homeCountry:(NSString *)homeCountry
{
    _pickupDate = pickupDate;
    _returnDate = returnDate;
    _pickupCode = pickupCode;
    _returnCode = returnCode;
    _homeCountry = homeCountry;
    _vehicle = vehicle;
    _api = api;
}

- (IBAction)termsAndCondTapped:(id)sender
{
    [self.api requestTermsAndConditions:self.pickupDate
                    returnDateTime:self.returnDate
                pickupLocationCode:self.pickupCode
                returnLocationCode:self.returnCode
                       homeCountry:self.homeCountry
                               car:self.vehicle
                        completion:^(CTTermsAndConditions *response, CTErrorResponse *error) {
                            NSLog(@"%@", response);
                        }];
}

#pragma mark Included Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IncludedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setDetails:@"Cancellation"];
    return cell;
}
@end
