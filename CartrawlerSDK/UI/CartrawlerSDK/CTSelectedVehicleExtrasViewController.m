//
//  CTSelectedVehicleExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 03/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleExtrasViewController.h"
#import "CTSelectedVehicleExtrasCell.h"
#import "CTSelectedVehicleExtrasViewModel.h"

@interface CTSelectedVehicleExtrasViewController ()
@property (nonatomic, strong) CTSelectedVehicleExtrasViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *viewAllButton;

@end

@implementation CTSelectedVehicleExtrasViewController

- (void)updateWithViewModel:(CTSelectedVehicleExtrasViewModel *)viewModel {
    BOOL collectionViewReload = viewModel.cellModels.count != self.viewModel.cellModels.count;
    
    self.viewModel = viewModel;
    [self.viewAllButton setTitleColor:viewModel.primaryColor forState:UIControlStateNormal];
    
    if (collectionViewReload) {
        [self.collectionView reloadData];
    } else {
        for (CTSelectedVehicleExtrasCell *cell in self.collectionView.visibleCells) {
            NSInteger index = [self.collectionView indexPathForCell:cell].row;
            [cell updateWithViewModel:viewModel.cellModels[index] animated:YES];
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

// MARK: Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.cellModels.count;
}

- (__kindof CTSelectedVehicleExtrasCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTSelectedVehicleExtrasCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SelectedVehicleExtras" forIndexPath:indexPath];
    [cell updateWithViewModel:self.viewModel.cellModels[indexPath.row] animated:NO];
    
    cell.contentView.layer.cornerRadius = 2.0f;
    cell.contentView.layer.borderWidth = 1.0f;
    cell.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    cell.contentView.layer.masksToBounds = YES;

    cell.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0, 1.0f);
    cell.layer.shadowRadius = 1.0f;
    cell.layer.shadowOpacity = 1.0f;
    cell.layer.masksToBounds = NO;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cell.bounds cornerRadius:cell.contentView.layer.cornerRadius].CGPath;
    
    return cell;
}

- (IBAction)viewAllButtonTapped:(UIButton *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapViewAllExtras payload:nil];
}

@end
