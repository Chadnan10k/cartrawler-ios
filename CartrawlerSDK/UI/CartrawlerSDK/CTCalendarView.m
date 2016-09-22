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

- (void)reset
{
    [self.logicController reset];
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
        if (weakSelf.discard != nil) {
            weakSelf.discard();
        }
    };
    
    self.logicController.datesSelected = ^(NSDate *pickup, NSDate *dropoff) {
        if (weakSelf.datesSelected != nil) {
            weakSelf.datesSelected(pickup, dropoff);
        }
    };
    
    self.logicController.dateSelected = ^(NSDate *date) {
        if (weakSelf.datesSelected) {
            weakSelf.datesSelected(date, nil);
        }
    };

    NSDate *date = [NSDate date];
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    NSInteger monthNumber = components.month;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CTCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarCell" forIndexPath:indexPath];
    if (self.mininumDate) {
        cell.mininumDate = self.mininumDate;
    }
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
    
    headerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    headerView.alpha = 0.9;
    [headerView addSubview:customLabel];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MMMM YYYY";
    NSString *dateStr = [df stringFromDate:self.months[section]];
    customLabel.text = dateStr;
    
    return headerView;
}

- (void)setupWeekDayTitle:(CGRect)frame
{
    
    [self.weekDayTitle.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width = (CGRectGetWidth(frame) - self.padding * 2) / 7;
    
    NSArray *titles = @[NSLocalizedString(@"Sun", @""),
                        NSLocalizedString(@"Mon", @""),
                        NSLocalizedString(@"Tue", @""),
                        NSLocalizedString(@"Wed", @""),
                        NSLocalizedString(@"Thu", @""),
                        NSLocalizedString(@"Fri", @""),
                        NSLocalizedString(@"Sat", @"")];
    
    NSMutableArray<CTLabel *> *labelArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 7; i++) {
        CTLabel *label = [[CTLabel alloc] initWithFrame:CGRectZero];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titles[i];
        label.textColor = [UIColor darkGrayColor];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        [self.weekDayTitle addSubview:label];
        [labelArray addObject:label];
    }
    
    if (labelArray.count == 7) {
        NSString *layoutStringH = @"H:|-0-[sun(width)]-0-[mon(width)]-0-[tue(width)]-0-[wed(width)]-0-[thu(width)]-0-[fri(width)]-0-[sat(width)]-0-|";
        NSString *layoutStringVSun = @"V:|-[sun]-|";
        NSString *layoutStringVMon = @"V:|-[mon]-|";
        NSString *layoutStringVTue = @"V:|-[tue]-|";
        NSString *layoutStringVWed = @"V:|-[wed]-|";
        NSString *layoutStringVThu = @"V:|-[thu]-|";
        NSString *layoutStringVFri = @"V:|-[fri]-|";
        NSString *layoutStringVSat = @"V:|-[sat]-|";

        NSDictionary *viewDict = @{@"sun" : labelArray[0],
                                   @"mon" : labelArray[1],
                                   @"tue" : labelArray[2],
                                   @"wed" : labelArray[3],
                                   @"thu" : labelArray[4],
                                   @"fri" : labelArray[5],
                                   @"sat" : labelArray[6]};
        
        NSDictionary *metrics = @{@"width" : [NSNumber numberWithFloat:width], @"lowPriority":@(UILayoutPriorityDefaultLow)};
        
        NSArray *hConstraint = [NSLayoutConstraint constraintsWithVisualFormat:layoutStringH
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict];
        
        [self.weekDayTitle addConstraints:hConstraint];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVSun
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVMon
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVTue
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVWed
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVThu
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVFri
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];
        [self.weekDayTitle addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:layoutStringVSat
                                                                                  options:0
                                                                                  metrics:metrics
                                                                                    views:viewDict]];

    }
}

@end
