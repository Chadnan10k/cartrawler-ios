//
//  CTSelectedVehicleAllExtrasDetailCell.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleAllExtrasDetailCell.h"
#import "CTSelectedVehicleExtrasCellModel.h"
#import "CTTriangleView.h"

@interface CTSelectedVehicleAllExtrasDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet CTTriangleView *triangleView;
@end

@implementation CTSelectedVehicleAllExtrasDetailCell

- (void)updateWithViewModel:(CTSelectedVehicleExtrasCellModel *)viewModel {
    self.title.text = viewModel.moreDetail;
    self.contentView.backgroundColor = viewModel.primaryColor;
    self.triangleView.color = viewModel.primaryColor;
    [self.triangleView setNeedsDisplay];
}

@end
