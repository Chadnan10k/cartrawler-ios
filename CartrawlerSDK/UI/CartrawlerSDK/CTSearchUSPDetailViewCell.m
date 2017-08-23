//
//  CTSearchUSPDetailViewCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 02/08/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchUSPDetailViewCell.h"
#import "CTSearchUSPDetailViewModel.h"
#import "CTCreditCardImageView.h"
#import "CTHeadsetImageView.h"
#import "CTMapImageView.h"
#import "CTSearchImageView.h"
#import "CTLockImageView.h"

@interface CTSearchUSPDetailViewCell ()
@property (nonatomic, readwrite) CTSearchUSPDetailViewModel *viewModel;
@property (weak, nonatomic) IBOutlet CTCreditCardImageView *creditCardImageView;
@property (weak, nonatomic) IBOutlet CTHeadsetImageView *headsetImageView;
@property (weak, nonatomic) IBOutlet CTMapImageView *mapImageView;
@property (weak, nonatomic) IBOutlet CTSearchImageView *searchImageView;
@property (weak, nonatomic) IBOutlet CTLockImageView *lockImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@end

@implementation CTSearchUSPDetailViewCell

- (void)updateWithViewModel:(CTSearchUSPDetailViewModel *)viewModel {
    self.creditCardImageView.alpha = viewModel.detailType == CTSearchUSPDetailTypeCreditCard;
    self.headsetImageView.alpha = viewModel.detailType == CTSearchUSPDetailTypeHeadset;
    self.mapImageView.alpha = viewModel.detailType == CTSearchUSPDetailTypeMap;
    self.searchImageView.alpha = viewModel.detailType == CTSearchUSPDetailTypeSearch;
    self.lockImageView.alpha = viewModel.detailType == CTSearchUSPDetailTypeLock;
    
    self.creditCardImageView.primaryColor = viewModel.primaryColor;
    [self.creditCardImageView setNeedsDisplay];
    
    self.headsetImageView.primaryColor = viewModel.primaryColor;
    [self.headsetImageView setNeedsDisplay];
    
    self.mapImageView.primaryColor = viewModel.primaryColor;
    [self.mapImageView setNeedsDisplay];
    
    self.searchImageView.primaryColor = viewModel.primaryColor;
    [self.searchImageView setNeedsDisplay];
    
    self.lockImageView.primaryColor = viewModel.primaryColor;
    [self.lockImageView setNeedsDisplay];
    
    self.titleLabel.text = viewModel.title;
    self.detailLabel.text = viewModel.detail;
}

@end
