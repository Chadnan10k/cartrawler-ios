//
//  CTInclusionsDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 27/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTVehicleFeaturesDataSource.h"
#import "CTVehicleFeatureTableViewCell.h"

@interface CTVehicleFeaturesDataSource()

@property (nonatomic, strong) NSArray < NSDictionary *> *items;

@end

@implementation CTVehicleFeaturesDataSource

- (instancetype)init
{
    self = [super init];
    _items = @[];
    return self;
}

- (void)setData:(NSArray < NSDictionary *> *)items
{
    _items = items;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    NSString *text = [self.items[indexPath.row] objectForKey:@"text"];
    UIImage *image = [UIImage imageNamed:[self.items[indexPath.row] objectForKey:@"image"] inBundle:b compatibleWithTraitCollection:nil];
    
    CTVehicleFeatureTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:text image:image];
    return cell;
}


@end
