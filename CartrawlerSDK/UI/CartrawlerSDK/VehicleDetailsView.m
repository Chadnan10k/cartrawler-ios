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
#import "TermsViewController.h"
#import "CTAppearance.h"
#import "CTLabel.h"
#import "CarRentalSearch.h"

#define kCellsPerRow 4

@interface VehicleDetailsView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *doorsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *bagsLabel;
@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *transmissionLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *vendorImageView;
@property (unsafe_unretained, nonatomic) IBOutlet CTLabel *vendorRatingLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *vendorRatingTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UICollectionView *includedCollectionView;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;

@property (strong, nonatomic) CarRentalSearch *search;
@property (strong, nonatomic) CartrawlerAPI *api;
@property (strong, nonatomic) NSDate *pickupDate;
@property (strong, nonatomic) NSDate *returnDate;
@property (strong, nonatomic) NSString *pickupCode;
@property (strong, nonatomic) NSString *returnCode;
@property (strong, nonatomic) NSString *homeCountry;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;

@end

@implementation VehicleDetailsView

+ (void)forceLinkerLoad_ {}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}

- (void)setupView
{
    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vehicle.pictureURL completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    [[CTImageCache sharedInstance] cachedImage: self.search.selectedVehicle.vendor.logoURL completion:^(UIImage *image) {
        self.vendorImageView.image = image;
    }];
    
    self.includedCollectionView.dataSource = self;
    self.includedCollectionView.delegate = self;
    
    self.vehicleNameLabel.text = self.search.selectedVehicle.vehicle.makeModelName;
    self.passengersLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.passengerQty.stringValue, NSLocalizedString(@"passengers", @"passengers")];
    self.doorsLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.doorCount.stringValue, NSLocalizedString(@"doors", @"doors")];
    
    if (self.search.selectedVehicle.vehicle.baggageQty.integerValue > 1) {
        self.bagsLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.baggageQty.stringValue, NSLocalizedString(@"bags", @"bags")];
    } else {
        self.bagsLabel.text = [NSString stringWithFormat:@"%@ %@", self.search.selectedVehicle.vehicle.baggageQty.stringValue, NSLocalizedString(@"bag", @"bags")];
    }
    
    self.transmissionLabel.text = self.search.selectedVehicle.vehicle.transmissionType;
    
    self.view.translatesAutoresizingMaskIntoConstraints = false;
    if (self.search.selectedVehicle.vendor.rating.overallScore != nil) {
        
        NSString *score = [NSString stringWithFormat:@"%.1f", self.search.selectedVehicle.vendor.rating.overallScore.floatValue * 2];
        
        NSMutableAttributedString *ratingString = [[NSMutableAttributedString alloc] init];
        
        NSAttributedString *dollars = [[NSAttributedString alloc] initWithString:score
                                                                      attributes:@{NSFontAttributeName:
                                                                                       [UIFont fontWithName:[CTAppearance instance].boldFontName size:18]}];
        
        NSAttributedString *dot = [[NSAttributedString alloc] initWithString:@"/"
                                                                  attributes:@{NSFontAttributeName:
                                                                                   [UIFont fontWithName:[CTAppearance instance].boldFontName size:14]}];
        
        NSAttributedString *cents = [[NSAttributedString alloc] initWithString:@"10"
                                                                    attributes:@{NSFontAttributeName:
                                                                                     [UIFont fontWithName:[CTAppearance instance].boldFontName size:14], NSForegroundColorAttributeName : [UIColor lightGrayColor]}];
        
        [ratingString appendAttributedString:dollars];
        [ratingString appendAttributedString:dot];
        [ratingString appendAttributedString:cents];
        
        self.ratingLabel.alpha = 1;
        self.vendorRatingTitle.alpha = 1;
        self.ratingLabel.attributedText = ratingString;
        
    } else {
        self.ratingLabel.alpha = 0;
        self.vendorRatingTitle.alpha = 0;
    }
    
    if (self.search.selectedVehicle.vehicle.pricedCoverages.count > 0) {
        [self.includedCollectionView reloadData];
    } else {
        self.heightChanged(-50);
    }
    
}

- (void)setData:(CarRentalSearch *)search
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
    _search = search;
    _api = api;
}

- (IBAction)termsAndCondTapped:(id)sender
{
    [self.api requestTermsAndConditions:self.pickupDate
                    returnDateTime:self.returnDate
                pickupLocationCode:self.pickupCode
                returnLocationCode:self.returnCode
                       homeCountry:self.homeCountry
                               car:self.search.selectedVehicle.vehicle
                        completion:^(CTTermsAndConditions *response, CTErrorResponse *error) {
                            if (error) {
                                
                            } else {
                                UINavigationController *nav = [self.storyboard instantiateViewControllerWithIdentifier:@"TermsViewControllerNav"];
                                TermsViewController *vc = (TermsViewController *)nav.topViewController;
                                [vc setData:response];
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    [self presentViewController:nav animated:YES completion:nil];
                                });
                            }
                        }];

}

#pragma mark Included Collection View

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.search.selectedVehicle.vehicle.pricedCoverages.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IncludedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setDetails:self.search.selectedVehicle.vehicle.pricedCoverages[indexPath.row].chargeDescription];
    
    self.collectionViewHeight.constant = self.includedCollectionView.contentSize.height;
    if (self.heightChanged) {
        self.heightChanged(self.includedCollectionView.contentSize.height);
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize cellSize = CGSizeMake(self.view.frame.size.width * 0.46, 50);
    
    return cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

@end
