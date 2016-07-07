//
//  OptionalExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "OptionalExtrasViewController.h"
#import "OptionalExtraTableViewCell.h"

@interface OptionalExtrasViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation OptionalExtrasViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //self.textView.backgroundColor = [UIColor redColor];
    
    self.textViewHeight.constant = self.textView.contentSize.height*2;
    [self.view layoutIfNeeded];
    
    [self.tableView reloadData];
    self.tableViewHeight.constant = self.tableView.contentSize.height;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.viewLoaded) {
        self.viewLoaded(self.scrollView.contentSize.height-150);
    }
}

- (void)viewDidLayoutSubviews {
    [self.textView setContentOffset:CGPointZero animated:NO];
}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  //  return self.extras.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionalExtraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
   // [cell setData:self.extras[indexPath.row]];
    return cell;
}

@end
