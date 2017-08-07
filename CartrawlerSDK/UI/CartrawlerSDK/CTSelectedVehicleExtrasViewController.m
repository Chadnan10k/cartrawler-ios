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

@end

@implementation CTSelectedVehicleExtrasViewController

- (void)updateWithViewModel:(CTSelectedVehicleExtrasViewModel *)viewModel {
    BOOL collectionViewReload = viewModel.cellModels.count != self.viewModel.cellModels.count;
    
    self.viewModel = viewModel;
    
    if (collectionViewReload) {
        [self.collectionView reloadData];
    }
}

// MARK: Collection View Cell Size

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
//    layout.itemSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
//    [self.collectionView reloadData];
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
//}
// MARK: Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.cellModels.count;
}

- (__kindof CTSelectedVehicleExtrasCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTSelectedVehicleExtrasCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SelectedVehicleExtras" forIndexPath:indexPath];
    [cell updateWithViewModel:self.viewModel.cellModels[indexPath.row]];
    
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


@end
