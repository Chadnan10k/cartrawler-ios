//
//  CTCalendarView.m
//  CartrawlerUIFramework
//
//  Created by Lee Maguire on 13/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTCalendarView.h"

#import "CTLabel.h"
#import "CTCalendarTableViewCell.h"
#import "CalendarLogicController.h"
#import "CTCalendarView.h"
#import "CTAppearance.h"

@interface CTCalendarView () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *weekDayTitle;

@property (strong, nonatomic) NSMutableArray<NSDate *> *months;
@property (strong, nonatomic) CalendarLogicController *logicController;

@end

@implementation CTCalendarView

+ (void)forceLinkerLoad_
{
    
}

- (void)setupWithFrame:(CGRect)frame
{

    
    // Do any additional setup after loading the view.
    _logicController = [[CalendarLogicController alloc] init];
    
    __weak typeof (self) weakSelf = self;
    
    self.logicController.refresh = ^{
        [weakSelf.tableView reloadData];
    };
    
    self.logicController.discard = ^{
        if (self.discard != nil) {
            weakSelf.discard();
        }
    };
    
    self.logicController.datesSelected = ^(NSDate *pickup, NSDate *dropoff){
        if (self.datesSelected != nil) {
            weakSelf.datesSelected(pickup, dropoff);
        }
    };

    NSDate *date = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger monthNumber = [components month];
    self.months = [[NSMutableArray alloc] init];
    
    for (NSInteger i = monthNumber; i < monthNumber + 12; i++) {
        NSCalendar *cal = [NSCalendar currentCalendar];
        NSDate *date = [cal dateByAddingUnit:NSCalendarUnitMonth value:i - monthNumber toDate:[NSDate date] options:0];
        [self.months addObject:date];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self setupWeekDayTitle:frame];
}

#pragma mark UITableView

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell" forIndexPath:indexPath];
    
    [cell setData:self.months[indexPath.section] section:indexPath.section logicController:self.logicController];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([(CTCalendarTableViewCell *)cell currentCollectionView] != nil) {
        [self.logicController pushCollectionView:[(CTCalendarTableViewCell *)cell currentCollectionView]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.logicController.cellHeights.count > indexPath.section) {
        return (CGFloat)self.logicController.cellHeights[indexPath.section].floatValue;
    } else {
        return 320;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 12;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CTLabel *customLabel = [[CTLabel alloc] initWithFrame:CGRectMake(10.0,5.0,200.0,20.0)];
    customLabel.textColor = [UIColor darkGrayColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200.0, 20)];
    
    [headerView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [headerView addSubview:customLabel];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMMM YYYY"];
    NSString *dateStr = [df stringFromDate:self.months[section]];
    [customLabel setText: dateStr];
    
    return headerView;
}

- (void)setupWeekDayTitle:(CGRect)frame
{
    [self.weekDayTitle.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = (CGRectGetWidth(frame) - self.padding * 2) / 7;
    CGFloat centerY = self.weekDayTitle.bounds.size.height / 2;
    
    NSArray *titles = @[NSLocalizedString(@"Sun", @""),
                        NSLocalizedString(@"Mon", @""),
                        NSLocalizedString(@"Tue", @""),
                        NSLocalizedString(@"Wed", @""),
                        NSLocalizedString(@"Thu", @""),
                        NSLocalizedString(@"Fri", @""),
                        NSLocalizedString(@"Sat", @"")];
    
    for (int i = 0; i < 7; i++) {
        CTLabel *label = [[CTLabel alloc] initWithFrame:CGRectMake(0, 0, width, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titles[i];
        label.center = CGPointMake(self.padding + i * width + width / 2, centerY);
        label.textColor = [UIColor darkGrayColor];
        [self.weekDayTitle addSubview:label];
    }
}

@end
