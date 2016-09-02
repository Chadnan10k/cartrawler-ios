//
//  InclusionCollectionViewDataSource.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InclusionTableViewDataSource.h"
#import "InclusionTableViewCell.h"

@interface InclusionTableViewDataSource()

@property (nonatomic, strong) NSArray <CTGroundInclusion *> *inclusions;

@end

@implementation InclusionTableViewDataSource

- (void)setInclusions:(NSArray <CTGroundInclusion *> *)inclusions;
{
    _inclusions = inclusions;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InclusionTableViewCell *cell = (InclusionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setText:@"Test"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

@end
