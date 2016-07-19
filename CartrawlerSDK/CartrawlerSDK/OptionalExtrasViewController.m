//
//  OptionalExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 07/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "OptionalExtrasViewController.h"
#import "OptionalExtraTableViewCell.h"
#import "CTAppearance.h"

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
    
    [self.tableView reloadData];
    self.tableViewHeight.constant = self.tableView.contentSize.height;
    
    NSString *extrasTitle = NSLocalizedString(@"Add a request for an additional driver, GPS, child seat or other extras. You will pay for these extras directly at the car rental supplier service desk on pick-up. Please note that availability of these extras is not always guaranteed", @"extras info");

    self.textView.text = extrasTitle;
    self.textView.font = [UIFont fontWithName:[CTAppearance instance].fontName size:15];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 80;
}

- (void)refreshView
{
    [self.tableView reloadData];
    self.tableViewHeight.constant = self.tableView.contentSize.height;
    
    CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];
    self.textViewHeight.constant = textViewSize.height;
    self.textView.scrollEnabled = NO;
    
    if (self.optionalExtrasLoaded) {
        self.optionalExtrasLoaded(50);
    }
}

- (void)setExtras:(NSArray<CTExtraEquipment *> *)extras
{
    _extras = extras;
    [self.tableView reloadData];

    self.tableViewHeight.constant = self.tableView.contentSize.height;
    
    CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];
    self.textViewHeight.constant = textViewSize.height;
    self.textView.scrollEnabled = NO;
    
    
    if (self.optionalExtrasLoaded) {
        self.optionalExtrasLoaded(self.tableViewHeight.constant + self.textViewHeight.constant + 50);
    }

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
    self.tableViewHeight.constant = self.tableView.contentSize.height;
    
    CGSize textViewSize = [self.textView sizeThatFits:CGSizeMake(self.textView.frame.size.width, FLT_MAX)];
    self.textViewHeight.constant = textViewSize.height;
    self.textView.scrollEnabled = NO;
    
    if (self.viewLoaded) {
        self.optionalExtrasLoaded(self.tableViewHeight.constant + self.textViewHeight.constant + 50);
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
    return self.extras.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OptionalExtraTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setData:self.extras[indexPath.row]];
    return cell;
}

@end
