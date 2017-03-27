//
//  CTInPathCarouselView.m
//  CartrawlerInPath
//
//  Created by Lee Maguire on 24/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCarouselView.h"
#import "CTCarouselCollectionViewCell.h"
#import <CartrawlerSDK/CTAppearance.h>

@interface CTCarouselView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *vehicleCollectionView;
@property (nonatomic, strong) UIButton *viewAllButton;

@property (nonatomic, weak) CTVehicleAvailability *availability;

@end

@implementation CTCarouselView

+ (CTCarouselView *)carouselFromAvail:(CTVehicleAvailability *)availability
{
    CTCarouselView *container = [CTCarouselView new];
    container.availability = availability;

    container.translatesAutoresizingMaskIntoConstraints = NO;
    
    [container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[container(240)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"container" : container}]];
    container.backgroundColor = [UIColor groupTableViewBackgroundColor];//remove for production
    
    container.vehicleCollectionView = [container renderCollectionView];
    container.viewAllButton = [container renderViewAllButton];
    [container layout];
    return container;
}

- (void)layout
{
    
    NSDictionary *viewDictionary = @{
                                     @"vehicleCollectionView" : self.vehicleCollectionView,
                                     @"viewAllButton" : self.viewAllButton
                                     };
    //Collection view
    [self addSubview:self.vehicleCollectionView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[vehicleCollectionView]-0-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[vehicleCollectionView]-40-|" options:0 metrics:nil views:viewDictionary]];
    
    //View all button
    [self addSubview:self.viewAllButton];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[viewAllButton]-8-|" options:0 metrics:nil views:viewDictionary]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[viewAllButton]-4-|" options:0 metrics:nil views:viewDictionary]];
    
    [self.viewAllButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[viewAllButton(0)]"
                                                                               options:0
                                                                               metrics:nil
                                                                                 views:viewDictionary]];
    
    for (NSLayoutConstraint *c in self.viewAllButton.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = self.viewAllButton.intrinsicContentSize.width + 24;
        }
    }
    
}

- (UICollectionView *)renderCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(240, 150);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [collectionView registerClass:[CTCarouselCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    return collectionView;
}

- (UIButton *)renderViewAllButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:@"SEE ALL" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(viewAllAction:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:17];
    [button setTitleColor:[CTAppearance instance].headerTitleColor forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = [CTAppearance instance].headerTitleColor.CGColor;
    button.layer.cornerRadius = 5;
    return button;
}

- (void)viewAllAction:(id)sender
{
    if (self.delegate) {
        [self.delegate didSelectViewAll];
    }
}

//MARK: UICollectionView DataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.availability.items.count >= 5 ? 5 : self.availability.items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTCarouselCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setVehicle:self.availability.items[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate) {
        [self.delegate didSelectVehicle:self.availability.items[indexPath.row]];
    }
}

@end
