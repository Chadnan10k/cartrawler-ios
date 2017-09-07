//
//  CTSelectedVehicleAllExtrasViewController.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 07/09/2017.
//  Copyright (c) 2017 Cartrawler. All rights reserved.
//

#import "CTSelectedVehicleAllExtrasViewController.h"
#import "CTSelectedVehicleAllExtrasViewModel.h"
#import "CTSelectedVehicleExtrasCellModel.h"
#import "CTAppController.h"

@interface CTSelectedVehicleAllExtrasViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;
@property (nonatomic, strong) CTSelectedVehicleAllExtrasViewModel *viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CTSelectedVehicleAllExtrasViewController

+ (Class)viewModelClass {
    return CTSelectedVehicleAllExtrasViewModel.class;
}

- (void)updateWithViewModel:(CTSelectedVehicleAllExtrasViewModel *)viewModel{
    self.viewModel = viewModel;
    self.navigationBar.barTintColor = viewModel.primaryColor;
    self.navigationBar.topItem.title = viewModel.title;
    [UIView transitionWithView: self.tableView
                      duration: 0.35f
                       options: UIViewAnimationOptionTransitionCrossDissolve
                    animations: ^(void)
     {
         [self.tableView reloadData];
     }
                    completion: nil];

}
    
- (IBAction)closeButtonTapped:(UIBarButtonItem *)sender {
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapCloseViewAllExtras payload:nil];
}

// MARK: Table View
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.cellModels.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTSelectedVehicleExtrasCellModel *cellModel = self.viewModel.cellModels[indexPath.row];
    NSString *identifier = cellModel.type == CTExtrasCellTypeList ? @"ListCell" : @"DetailCell";
    UITableViewCell <CTViewControllerProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.backgroundColor = [UIColor clearColor];
    [cell updateWithViewModel:self.viewModel.cellModels[indexPath.row]];
    
    return cell;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CTExtraEquipment *extra = self.viewModel.cellModels[indexPath.row].extra;
    [CTAppController dispatchAction:CTActionSelectedVehicleUserDidTapExtra payload:extra];
}
    
- (IBAction)backButtonTapped:(id)sender {
    [CTAppController dispatchAction:CTActionVehicleListUserDidTapBack payload:nil];
}
    
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        [CTAppController dispatchAction:CTActionUserSettingsUserDidShake payload:nil];
    }
}

@end
