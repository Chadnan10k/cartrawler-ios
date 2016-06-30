//
//  CTFilterViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 30/06/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTFilterViewController.h"
#import "CTFilterDataSource.h"

@interface CTFilterViewController ()
@property (weak, nonatomic) IBOutlet UITableView *carSizeTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *carSizeHeightConstraint;
@property (weak, nonatomic) IBOutlet UITableView *pickupLocationTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickupLocationConstraint;
@property (weak, nonatomic) IBOutlet UITableView *vendorsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *vendorsConstraint;

@property (strong, nonatomic) CTFilterDataSource *carSizeDataSource;
@property (strong, nonatomic) CTFilterDataSource *locationDataSource;
@property (strong, nonatomic) CTFilterDataSource *vendorsDataSource;
@property (strong, nonatomic) NSMutableArray *selectedData;

@end

@implementation CTFilterViewController

+ (void)forceLinkerLoad_
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _selectedData = [[NSMutableArray alloc] init];
    
    NSArray *sizeArray = @[@"Small", @"Medium", @"Large", @"People carriers", @"SUV"];
    
    _carSizeDataSource = [[CTFilterDataSource alloc] initWithData:sizeArray selectedData:self.selectedData];
    _locationDataSource = [[CTFilterDataSource alloc] initWithData:@[@"In terminal", @"Free shuttle bus"] selectedData:self.selectedData];
    _vendorsDataSource = [[CTFilterDataSource alloc] initWithData:@[@"Avis", @"Hertz"] selectedData:self.selectedData];

    self.carSizeTableView.dataSource = self.carSizeDataSource;
    self.carSizeTableView.delegate = self.carSizeDataSource;
    self.pickupLocationTableView.dataSource = self.locationDataSource;
    self.pickupLocationTableView.delegate = self.locationDataSource;
    self.vendorsTableView.dataSource = self.vendorsDataSource;
    self.vendorsTableView.delegate = self.vendorsDataSource;
    
    [self.carSizeTableView reloadData];
    [self.pickupLocationTableView reloadData];
    [self.vendorsTableView reloadData];

    self.carSizeHeightConstraint.constant = self.carSizeTableView.contentSize.height;
    self.pickupLocationConstraint.constant = self.pickupLocationTableView.contentSize.height;
    self.vendorsConstraint.constant = self.vendorsTableView.contentSize.height;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
