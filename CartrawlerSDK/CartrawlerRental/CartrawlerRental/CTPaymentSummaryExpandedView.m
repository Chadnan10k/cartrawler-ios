//
//  CTPaymentSummaryExpandedView.m
//  CartrawlerSDK
//
//  Created by Alan on 27/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTPaymentSummaryExpandedView.h"
#import <CartrawlerSDK/CTLayoutManager.h>
#import "CTPaymentSummaryExpandedTableViewCell.h"
#import <CartrawlerSDK/CartrawlerSDK+NSNumber.h>
#import <CartrawlerSDK/CTLocalisedStrings.h>
#import "CTRentalLocalizationConstants.h"

@interface CTPaymentSummaryExpandedView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CTVehicle *vehicle;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, strong) UIView *divider;
@property (nonatomic, strong) UIView *rentalTotalView;
@property (nonatomic, strong) CTLabel *rentalTotalLabel;
@property (nonatomic, strong) UIView *chevron;

@property (nonatomic, strong) CTLayoutManager *layoutManager;
@end

@implementation CTPaymentSummaryExpandedView

// MARK: View Creation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.containerView = [self createContainerView];
        [self addSubview:self.containerView];
        
        self.tableView = [self createTableView];
        [self.containerView addSubview:self.tableView];
        
        self.divider = [self createDivider];
        [self.containerView addSubview:self.divider];
        
        self.rentalTotalView = [self createRentalTotalView];
        [self.containerView addSubview:self.rentalTotalView];
        
        self.chevron = [self createChevron];
        [self addSubview:self.chevron];
        
        [self applyConstraints];
    }
    return self;
}

- (UIView *)createContainerView {
    UIView *containerView = [UIView new];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    containerView.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
    return containerView;
}

- (UITableView *)createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    tableView.dataSource = self;
    tableView.delegate = self;
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsHorizontalScrollIndicator = NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.rowHeight = 20;
    [tableView registerClass:CTPaymentSummaryExpandedTableViewCell.class forCellReuseIdentifier:@"cell"];
    tableView.scrollEnabled = NO;
    
    return tableView;
}

- (UIView *)createDivider {
    UIView *divider = [UIView new];
    divider.translatesAutoresizingMaskIntoConstraints = NO;
    divider.backgroundColor = [UIColor whiteColor];
    return divider;
}

- (UIView *)createRentalTotalView {
    UIView *rentalTotalView = [UIView new];
    rentalTotalView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CTLabel *titleLabel = [[CTLabel alloc] init:20.0
                                      textColor:[UIColor whiteColor]
                                  textAlignment:NSTextAlignmentLeft
                                       boldFont:YES];
    titleLabel.text = CTLocalizedString(CTRentalCarRentalTotal);
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [rentalTotalView addSubview:titleLabel];
    
    CTLabel *rentalTotalLabel = [[CTLabel alloc] init:20.0
                                            textColor:[UIColor whiteColor]
                                        textAlignment:NSTextAlignmentRight
                                             boldFont:YES];
    rentalTotalLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [rentalTotalView addSubview:rentalTotalLabel];
    self.rentalTotalLabel = rentalTotalLabel;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(titleLabel, rentalTotalLabel);
    [rentalTotalView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[titleLabel]-[rentalTotalLabel]|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
    [rentalTotalLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [rentalTotalView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:views]];
    [rentalTotalView addConstraint:[NSLayoutConstraint constraintWithItem:titleLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:rentalTotalLabel
                                                                attribute:NSLayoutAttributeCenterY
                                                               multiplier:1.0
                                                                 constant:0.0]];
    
    return rentalTotalView;
}

- (UIView *)createChevron {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *chevronImage = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *chevronImageView = [[UIImageView alloc] initWithImage:chevronImage];
    chevronImageView.tintColor = [UIColor whiteColor];
    chevronImageView.translatesAutoresizingMaskIntoConstraints = NO;
    chevronImageView.transform = CGAffineTransformMakeScale(1, -1);
    
    UIView *chevron = [UIView new];
    chevron.translatesAutoresizingMaskIntoConstraints = NO;
    chevron.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
    [chevron addSubview:chevronImageView];
    
    [chevron addConstraint:[NSLayoutConstraint constraintWithItem:chevronImageView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:chevron
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.3
                                                         constant:0.0]];
    [chevron addConstraint:[NSLayoutConstraint constraintWithItem:chevronImageView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:chevron
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0.3
                                                         constant:0.0]];
    [chevron addConstraint:[NSLayoutConstraint constraintWithItem:chevron
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:chevronImageView
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
    [chevron addConstraint:[NSLayoutConstraint constraintWithItem:chevron
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:chevronImageView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:-5.0]];
    return chevron;
}

- (void)applyConstraints {
    NSDictionary *views = @{@"containerView": self.containerView, @"tableView": self.tableView, @"divider": self.divider, @"rentalTotalView": self.rentalTotalView, @"chevron": self.chevron};
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[tableView]-20-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[divider]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[rentalTotalView]-20-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[tableView]-10-[divider(1)]-10-[rentalTotalView]-10-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:views]];
    self.tableViewHeightConstraint = [NSLayoutConstraint constraintWithItem:self.tableView
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0
                                                                   constant:self.tableView.contentSize.height];
    [self addConstraint:self.tableViewHeightConstraint];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.chevron
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.chevron
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevron
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:40.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevron
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.chevron
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0.0]];
}

// MARK: View Update

- (void)updateWithVehicle:(CTVehicle *)vehicle {
    self.vehicle = vehicle;
    
    self.rentalTotalLabel.text = [vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
}

- (CGFloat)desiredHeight {
    return self.tableView.contentSize.height + self.divider.intrinsicContentSize.height + 40 + self.rentalTotalLabel.intrinsicContentSize.height + 15;
}

// MARK: Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? 1 : MAX(1, [self extrasForVehicle:self.vehicle includedInRate:NO].count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTPaymentSummaryExpandedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
    return (indexPath.section == 0) ? [self formattedPayNowCell:cell] : [self formattedPayAtDeskCell:cell atIndex:indexPath.row];
}

- (CTPaymentSummaryExpandedTableViewCell *)formattedPayNowCell:(CTPaymentSummaryExpandedTableViewCell *)cell {
    cell.titleLabel.text = CTLocalizedString(CTRentalCarRental);
    cell.detailLabel.text = [self.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    return cell;
}

- (CTPaymentSummaryExpandedTableViewCell *)formattedPayAtDeskCell:(CTPaymentSummaryExpandedTableViewCell *)cell atIndex:(NSInteger)index {
    NSArray *extras = [self extrasForVehicle:self.vehicle includedInRate:NO];
    if (extras.count == 0) {
        cell.titleLabel.text = CTLocalizedString(CTRentalPayNothingAtDesk);
    }
    
    if (index < extras.count) {
        CTExtraEquipment *extraEquipment = extras[index];
        cell.titleLabel.text = extraEquipment.equipDescription;
        cell.detailLabel.text = [extraEquipment.chargeAmount numberStringWithCurrencyCode];
    }
    return cell;
}

// MARK: UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CTLabel *headerLabel = [CTLabel new];
    headerLabel.textColor = [UIColor colorWithRed:240.0/255.0 green:200.0/255.0 blue:68.0/255.0 alpha:1.0];
    headerLabel.font = [UIFont italicSystemFontOfSize: 16.0];
    headerLabel.translatesAutoresizingMaskIntoConstraints = NO;
    headerLabel.text = (section == 0) ? CTLocalizedString(CTRentalPayNow) : CTLocalizedString(CTRentalPayAtDesk);
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
    [view addSubview:headerLabel];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[headerLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(headerLabel)]];
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerLabel]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(headerLabel)]];
    
    return view;
}

// MARK: Image Rounding

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.chevron.layer.cornerRadius = self.chevron.frame.size.width / 2;
}

// MARK: View Model Logic

- (NSArray *)extrasForVehicle:(CTVehicle *)vehicle includedInRate:(BOOL)includedInRate {
    return [vehicle.extraEquipment filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(CTExtraEquipment *extraEquipment, NSDictionary<NSString *,id> * _Nullable bindings) {
        return extraEquipment.qty > 0 && extraEquipment.isIncludedInRate == includedInRate;
    }]];
}

@end
