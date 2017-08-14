//
//  UsageViewController.m
//  TestApp
//
//  Created by Alan on 21/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "UsageViewController.h"
#import <CarTrawlerSDK/CTHeaders.h>

@interface UsageViewController () <CTListViewDelegate>
@property (nonatomic, strong) NSArray *rowData;
@end

@implementation UsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rowData = @[
                     @[@"Alert with Title & Message", @"CTAlertViewController"],
                     @[@"Alert with Title & Buttons", @"CTAlertViewController"],
                     @[@"Alert with Title & Custom View", @"CTAlertViewController"],
                     @[@"Tabbed Menu", @"CTTabContainerView"],
                     @[@"Info Tip", @"CTInfoTip"],
                     @[@"List with Expanding Views", @"CTListView & CTExpandingView"],
                     @[@"Rating View", @"CTRatingView"]
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
            [self presentTabbedMenuWithVariableHeight];
            break;
        case 4:
            [self presentInfoTip];
            break;
        case 5:
            [self presentExpandingView];
            break;
        case 6:
            [self presentRatingView];
            break;
        default:
            break;
    }
}


- (void)presentAlertControllerWithTitleAndMessage {
//    CTAlertViewController *controller = [CTAlertViewController alertControllerWithTitle:@"Alert with Title and Message" message:@"Tap background to dismiss has been enabled"];
//    controller.backgroundTapDismissalGestureEnabled = YES;
//    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentAlertControllerWithTitleAndButtons {
//    CTAlertViewController *controller = [CTAlertViewController alertControllerWithTitle:@"Alert with Title and Buttons" message:@"Tap background to dismiss has not been enabled"];
//    
//    CTAlertAction *action1 = [CTAlertAction actionWithTitle:@"OK" handler:^(CTAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [controller addAction:action1];
//    
//    CTAlertAction *action2 = [CTAlertAction actionWithTitle:@"Cancel" handler:^(CTAlertAction *action) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }];
//    [controller addAction:action2];
//    
//    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentAlertControllerWithCustomView {
//    CTAlertViewController *controller = [CTAlertViewController alertControllerWithTitle:@"Alert with Title and Custom View" message:@""];
//    controller.backgroundTapDismissalGestureEnabled = YES;
//    
//    UIImage *appIcon = [UIImage imageNamed:@"AppIcon40x40"];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:appIcon];
//    imageView.contentMode = UIViewContentModeScaleAspectFit;
//    controller.customView = imageView;
//    
//    [self presentViewController:controller animated:YES completion:nil];
}

- (void)presentTabbedMenuWithVariableHeight {
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = [UIColor whiteColor];
    
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
    containerView.animationContainerView = controller.view;
    [self presentView:containerView inViewController:controller height:0];
}

- (void)presentInfoTip {
    UIImage *icon = [UIImage imageNamed:@"calEnd"];
    CTInfoTip *infoTip = [[CTInfoTip alloc] initWithIcon:icon text:@"This is an info tip"];
    [self presentView:infoTip height:0];
}

- (void)presentExpandingView {
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = [UIColor whiteColor];
    
    UIImage *icon = [UIImage imageNamed:@"calEnd"];
    CTListItemView *itemView1 = [CTListItemView new];
    itemView1.titleLabel.text = @"Header 1";
    itemView1.imageView.image = icon;
    CTListItemView *itemView2 = [CTListItemView new];
    itemView2.titleLabel.text = @"Header 2";
    itemView2.imageView.image = icon;

    
    CTExpandingView *expandingView1 = [[CTExpandingView alloc] initWithHeaderView:itemView1 animationContainerView:controller.view];
    CTExpandingView *expandingView2 = [[CTExpandingView alloc] initWithHeaderView:itemView2 animationContainerView:controller.view];
    
    CTListView *listView = [[CTListView alloc] initWithViews:@[expandingView1, expandingView2] separatorColor:nil];
    listView.delegate = self;
    
    [self presentView:listView inViewController:controller height:0];
}

- (void)listView:(CTListView *)listView didSelectView:(CTExpandingView *)expandingView atIndex:(NSInteger)index {
    if (expandingView.expanded) {
        [expandingView contract];
    } else {
        UILabel *label = [UILabel new];
        label.numberOfLines = 0;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor lightGrayColor];
        label.text = @"\n\nDetail\n\nView\n\n";
        [expandingView expandWithDetailView:label];
    }
}

- (void)presentRatingView {
    CTRatingView *ratingView = [CTRatingView new];
    ratingView.titleLabel.text = @"Value for money";
    ratingView.ratingLabel.text = @"8.9";
    [self presentView:ratingView height:0];
}

// MARK: Helpers

- (void)presentView:(UIView *)view height:(CGFloat)height  {
    UIViewController *controller = [UIViewController new];
    controller.view.backgroundColor = [UIColor whiteColor];
    [self presentView:view inViewController:controller height:height];
}

- (void)presentView:(UIView *)view inViewController:(UIViewController *)controller height:(CGFloat)height {
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
