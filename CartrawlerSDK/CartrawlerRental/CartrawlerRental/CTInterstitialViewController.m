//
//  CTInsterstitialViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 29/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInterstitialViewController.h"
#import "CTInterstitialCollectionViewCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>
#import "CTRentalConstants.h"
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>

@interface CTInterstitialViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *vendorCollectionView;
@property (nonatomic, strong) NSArray <UIImage *>* vendorImages;
@property (nonatomic, strong) CTRentalSearch *search;
@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingDetailLabel;

@end

@implementation CTInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.vendorCollectionView.dataSource = self;
    self.vendorCollectionView.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.loadingLabel.text = CTLocalizedString(CTRentalInterstitialSearching1);
    self.loadingDetailLabel.text = CTLocalizedString(CTRentalInterstitialSearching2);
    
    _vendorImages = @[[UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_sixt" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_budget" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_alamo" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_hertz" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_enterprise" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]
                      ];

    [self.vendorCollectionView reloadData];
    
    if ([self.spinnerImageView.layer animationForKey:@"SpinAnimation"] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
        animation.duration = 1.0f;
        animation.repeatCount = INFINITY;
        [self.spinnerImageView.layer addAnimation:animation forKey:@"SpinAnimation"];
    }
    
    [self produceHeaderText];
}

- (void)produceHeaderText
{
    if (self.search.pickupLocation == self.search.dropoffLocation) {
        self.locationLabel.text = [NSString stringWithFormat:@"%@", self.search.pickupLocation.name];
    } else {
        self.locationLabel.text = [NSString stringWithFormat:@"%@\n- to -\n%@",
                                    self.search.pickupLocation.name, self.search.dropoffLocation.name];
    }
    
    NSString *pickupDate = [self.search.pickupDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    NSString *dropoffDate = [self.search.dropoffDate stringFromDateWithFormat:@"dd MMM, hh:mm a"];
    
    self.dateLabel.text = [NSString stringWithFormat:@"%@ - %@", pickupDate, dropoffDate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)sharedInstance
{
    static CTInterstitialViewController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSBundle *b = [NSBundle bundleForClass:[self class]];
        UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:CTRentalInterstitialStoryboard bundle:b];
        sharedInstance = [settingsStoryboard instantiateViewControllerWithIdentifier:CTRentalInterstitialViewIdentifier];
    });
    return sharedInstance;
}

+ (void)present:(UIViewController *)viewController search:(CTRentalSearch *)search;
{

    [[CTInterstitialViewController sharedInstance] setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [[CTInterstitialViewController sharedInstance] setModalPresentationStyle:UIModalPresentationOverFullScreen];
    [CTInterstitialViewController sharedInstance].search = search;
    [viewController presentViewController:[CTInterstitialViewController sharedInstance] animated:YES completion:nil];
}

+ (void)dismiss
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[CTInterstitialViewController sharedInstance] dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.vendorImages.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTInterstitialCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setData:self.vendorImages[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    [(CTInterstitialCollectionViewCell *)cell animate:indexPath.row];
}

#pragma mark Collection view layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize elementSize = CGSizeMake((self.view.frame.size.width/3)-16, 50);
    return elementSize;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 2.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(8,8,8,8);
}


@end
