//
//  UsageViewController.m
//  TestApp
//
//  Created by Alan on 21/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "UsageViewController.h"
#import <CarTrawlerSDK/CTHeaders.h>

@interface UsageViewController ()
@property (nonatomic, strong) NSArray *rowData;
@end

@implementation UsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowData = @[
                     @[@"Alert with Title & Message", @"CTAlertViewController"],
                     @[@"Alert with Title & Buttons", @"CTAlertViewController"],
                     @[@"Alert with Title & Custom View", @"CTAlertViewController"],
                     @[@"Tabbed Menu with fixed height", @"CTTabContainerView"],
                     @[@"Tabbed Menu with variable height", @"CTTabContainerView"],
                     @[@"Info Tip", @"CTInfoTip"],
                     ];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *data = self.rowData[indexPath.row];
    cell.textLabel.text = data.firstObject;
    cell.detailTextLabel.text = data.lastObject;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self presentAlertControllerWithTitleAndMessage];
            break;
        case 1:
            [self presentAlertControllerWithTitleAndButtons];
            break;
        case 2:
            [self presentAlertControllerWithCustomView];
            break;
        case 3:
            [self presentTabbedMenuWithFixedHeight];
            break;
        case 4:
            [self presentTabbedMenuWithVariableHeight];
            break;
        case 5:
            [self presentInfoTip];
            break;
        default:
            break;
    }
}


- (void)presentAlertControllerWithTitleAndMessage {
    CTAlertViewController *controller = [CTAlertViewController alertControllerWithTitle:@"Alert with Title and Message" message:@"Tap background to dismiss has been enabled"];
    controller.backgroundTapDismissalGestureEnabled = YES;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentAlertControllerWithTitleAndButtons {
    CTAlertViewController *controller = [CTAlertViewController alertControllerWithTitle:@"Alert with Title and Buttons" message:@"Tap background to dismiss has not been enabled"];
    
    CTAlertAction *action1 = [CTAlertAction actionWithTitle:@"OK" handler:^(CTAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:action1];
    
    CTAlertAction *action2 = [CTAlertAction actionWithTitle:@"Cancel" handler:^(CTAlertAction *action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [controller addAction:action2];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentAlertControllerWithCustomView {
    CTAlertViewController *controller = [CTAlertViewController alertControllerWithTitle:@"Alert with Title and Custom View" message:@""];
    controller.backgroundTapDismissalGestureEnabled = YES;
    
    UIImage *appIcon = [UIImage imageNamed:@"AppIcon40x40"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:appIcon];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    controller.customView = imageView;
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentTabbedMenuWithFixedHeight {
    NSMutableArray *titles = [NSMutableArray new];
    NSMutableArray *views = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        [titles addObject:[NSString stringWithFormat:@"Header %d", i+1]];
        
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = [NSString stringWithFormat:@"Detail View %d", i+1];
        [views addObject:label];
    }
    
    CTTabContainerView *containerView = [[CTTabContainerView alloc] initWithTabTitles:titles.copy views:views.copy selectedIndex:0];
    [self presentView:containerView height:200];
}

- (void)presentTabbedMenuWithVariableHeight {
    NSArray *titles = @[@"Short View", @"Tall View"];
    
    UILabel *label1 = [UILabel new];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.backgroundColor = [UIColor yellowColor];
    label1.text = [NSString stringWithFormat:@"Short View"];
    
    UILabel *label2 = [UILabel new];
    label2.textAlignment = NSTextAlignmentCenter;
    label2.numberOfLines = 0;
    label2.backgroundColor = [UIColor greenColor];
    label2.text = [NSString stringWithFormat:@"Tall View\nTall View\nTall View\nTall View\nTall View\nTall View\nTall View"];
    
    CTTabContainerView *containerView = [[CTTabContainerView alloc] initWithTabTitles:titles views:@[label1, label2] selectedIndex:0];
    [self presentView:containerView height:0];
}

- (void)presentInfoTip {
    UIImage *icon = [UIImage imageNamed:@"calEnd"];
    CTInfoTip *infoTip = [[CTInfoTip alloc] initWithIcon:icon text:@"This is an info tip"];
    [self presentView:infoTip height:0];
}

// MARK: Helpers

- (void)presentView:(UIView *)view height:(CGFloat)height  {
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = [UIColor whiteColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [controller.view addSubview:view];
    
    [controller.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"view" : view}]];
    
    NSString *constrainedHeight = (height == 0) ? @"" : [NSString stringWithFormat:@"(%f)", height];
    NSString *verticalFormat = [NSString stringWithFormat:@"V:|-200-[view%@]", constrainedHeight];
    [controller.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:verticalFormat
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"view" : view}]];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
