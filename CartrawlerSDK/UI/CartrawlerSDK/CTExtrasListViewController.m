//
//  CTExtrasListViewController.m
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasListViewController.h"
#import "CTExtrasCollectionView.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"
#import "CTExtrasListCollectionViewCell.h"

@interface CTExtrasListViewController ()
@property (nonatomic, strong) NSArray *extras;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *extrasContainerView;
@property (nonatomic, strong) CTExtrasCollectionView *extrasCollectionView;
@end

@implementation CTExtrasListViewController

static NSString * const reuseIdentifier = @"extra";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = CTLocalizedString(CTRentalAddExtrasTitle);
    self.extrasCollectionView = [[CTExtrasCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.extrasContainerView addSubview:self.extrasCollectionView];
    [CTLayoutManager pinView:self.extrasCollectionView toSuperView:self.extrasContainerView];
    [self.extrasCollectionView updateWithExtras:self.extras];
}

- (void)updateWithExtras:(NSArray <CTExtraEquipment *> *)extras {
    self.extras = extras;
    [self.extrasCollectionView updateWithExtras:self.extras];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
