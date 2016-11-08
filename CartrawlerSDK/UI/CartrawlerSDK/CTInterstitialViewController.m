//
//  CTInsterstitialViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 29/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTInterstitialViewController.h"
#import "CTInterstitialCollectionViewCell.h"

@interface CTInterstitialViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *vendorCollectionView;
@property (nonatomic, strong) NSArray <UIImage *>* vendorImages;

@end

@implementation CTInterstitialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.vendorCollectionView.dataSource = self;
    self.vendorCollectionView.delegate = self;

    _vendorImages = @[[UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil],
                      [UIImage imageNamed:@"vendor_europcar" inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil]
                      ];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.spinnerImageView.layer animationForKey:@"SpinAnimation"] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2*M_PI];
        animation.duration = 1.0f;
        animation.repeatCount = INFINITY;
        [self.spinnerImageView.layer addAnimation:animation forKey:@"SpinAnimation"];
    }
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
        UIStoryboard *settingsStoryboard = [UIStoryboard storyboardWithName:@"Interstitial" bundle:b];
        sharedInstance = [settingsStoryboard instantiateViewControllerWithIdentifier:@"CTInterstitialViewController"];
    });
    return sharedInstance;
}

+ (void)present:(UIViewController *)viewController
{

    [[CTInterstitialViewController sharedInstance] setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [[CTInterstitialViewController sharedInstance] setModalPresentationStyle:UIModalPresentationOverFullScreen];

    [viewController presentViewController:[CTInterstitialViewController sharedInstance] animated:YES completion:nil];
}

+ (void)dismiss
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //[[CTInterstitialViewController sharedInstance].spinnerImageView.layer removeAnimationForKey:@"SpinAnimation"];
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

#pragma mark Collection view layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize elementSize = CGSizeMake(104, 50);
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
