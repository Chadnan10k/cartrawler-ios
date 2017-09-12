//
//  CTSearchUSPViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchUSPViewController.h"
#import "CTSearchUSPViewModel.h"
#import "CTSearchUSPDetailViewCell.h"
#import "CTAppController.h"

@interface CTSearchUSPViewController () <UICollectionViewDataSource>
@property (nonatomic, strong) CTSearchUSPViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@end

@implementation CTSearchUSPViewController

- (void)updateWithViewModel:(CTSearchUSPViewModel *)viewModel {
    
    self.titleLabel.text = viewModel.title;
    self.pageControl.currentPage = viewModel.pageIndex;
    self.pageControl.numberOfPages = viewModel.numberOfPages;
    BOOL collectionViewItemsChange = viewModel.detailViewModels.count != self.viewModel.detailViewModels.count;
    BOOL collectionViewColorChange = ![viewModel.detailViewModels.firstObject.primaryColor isEqual:self.viewModel.detailViewModels.firstObject.primaryColor];
    self.viewModel = viewModel;
    self.pageControl.pageIndicatorTintColor = viewModel.pageControlTintColor;
    self.pageControl.currentPageIndicatorTintColor = viewModel.currentPageControlTintColor;
    if (collectionViewItemsChange || collectionViewColorChange) {
        [self.collectionView reloadData];
    } else {
        for (CTSearchUSPDetailViewCell *cell in self.collectionView.visibleCells) {
            NSInteger index = [self.collectionView indexPathForCell:cell].row;
            [cell updateWithViewModel:viewModel.detailViewModels[index]];
        }
    }
}

// MARK: Collection View Cell Size

- (void)viewDidLoad {
    [super viewDidLoad];
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    layout.itemSize = CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height);
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CGRectGetWidth(collectionView.frame), (CGRectGetHeight(collectionView.frame)));
}
// MARK: Collection View Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.detailViewModels.count;
}

- (__kindof CTSearchUSPDetailViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CTSearchUSPDetailViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"SearchUSPDetail" forIndexPath:indexPath];
    [cell updateWithViewModel:self.viewModel.detailViewModels[indexPath.row]];
    [cell setNeedsDisplay];
    return cell;
}

// MARK: Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (page != self.pageControl.currentPage) {
        [CTAppController dispatchAction:CTActionSearchUserDidSwipeUSPCarousel payload:@(page)];
    }
}

@end
