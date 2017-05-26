//
//  CTTermsViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 05/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTTermsViewController.h"
#import "CTTermsDetailViewController.h"
#import <CartrawlerSDK/CTSDKSettings.h>
#import <CartrawlerSDK/CTRentalSearch.h>
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>
#import "CTRentalLocalizationConstants.h"
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import <CartrawlerSDK/CTAnalytics.h>

@interface CTTermsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) CTTermsAndConditions *data;
@property (strong, nonatomic) CartrawlerAPI *api;
@property (strong, nonatomic) CTRentalSearch *search;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;

@end

@implementation CTTermsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titleLabel.text = CTLocalizedString(CTRentalTitleConditions);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    __weak typeof (self) weakSelf = self;
    
    [self.api requestTermsAndConditions:self.search.pickupDate
                              returnDateTime:self.search.dropoffDate
                          pickupLocationCode:self.search.pickupLocation.code
                          returnLocationCode:self.search.dropoffLocation.code
                                 homeCountry:[CTSDKSettings instance].homeCountryCode
                                         car:self.search.selectedVehicle.vehicle
                                  completion:^(CTTermsAndConditions *response, CTErrorResponse *error) {
                                      if (error) {

                                      } else {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              weakSelf.data = response;
                                              [weakSelf.tableView reloadData];
                                          });
                                      }
                                  }];
    
}

- (void)setData:(CTRentalSearch *)data cartrawlerAPI:(CartrawlerAPI *)cartrawlerAPI;
{
    _search = data;
    _api = cartrawlerAPI;
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
    cell.textLabel.font = [UIFont fontWithName:[CTAppearance instance].fontName size:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CTTermAndCondition *item = self.data.termsAndConditions[indexPath.row];
//    [[CTAnalytics instance] tagScreen:item.titleNameId detail:@"open" step:nil]; removed as it was causing crash in RYR app
    [self performSegueWithIdentifier:@"showTermsDetail" sender:self.data.termsAndConditions[indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CTTermsDetailViewController *vc = segue.destinationViewController;
    CTTermAndCondition *tc = (CTTermAndCondition *)sender;
    [vc setData:tc];
}



@end
