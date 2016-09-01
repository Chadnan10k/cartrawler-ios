//
//  TermsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "TermsViewController.h"
#import "TermsDetailViewController.h"

@interface TermsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CTTermsAndConditions *data;

@end

@implementation TermsViewController

+ (void)forceLinkerLoad_{}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)setData:(CTTermsAndConditions *)data
{
    _data = data;
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.termsAndConditions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.data.termsAndConditions[indexPath.row].titleText;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showTermsDetail" sender:self.data.termsAndConditions[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TermsDetailViewController *vc = segue.destinationViewController;
    CTTermAndCondition *tc = (CTTermAndCondition *)sender;
    [vc setData:tc];
}



@end
