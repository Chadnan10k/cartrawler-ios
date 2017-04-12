//
//  CTExtrasViewController.m
//  CartrawlerRental
//
//  Created by Alan on 11/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTExtrasViewController.h"
#import "CTExtrasCollectionView.h"
#import "CTLayoutManager.h"
#import "CTLabel.h"

@interface CTExtrasViewController ()
@property (nonatomic, strong) NSArray *extras;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (nonatomic, strong) CTExtrasCollectionView *collectionView;
@end

@implementation CTExtrasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"Add Extras";
    
    self.collectionView = [[CTExtrasCollectionView alloc] initWithScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView updateWithExtras:self.extras];
    [self.containerView addSubview:self.collectionView];
    [CTLayoutManager pinView:self.collectionView toSuperView:self.containerView];
}

- (void)updateWithExtras:(NSArray *)extras {
    self.extras = extras;
    [self.collectionView updateWithExtras:self.extras];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
