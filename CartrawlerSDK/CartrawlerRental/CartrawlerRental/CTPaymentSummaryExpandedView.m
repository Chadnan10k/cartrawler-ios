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
#import "CTRentalLocalizationConstants.h"

@interface CTPaymentSummaryExpandedView () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) CTRentalSearch *search;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSLayoutConstraint *tableViewHeightConstraint;
@property (nonatomic, strong) UIView *divider;
@property (nonatomic, strong) UIView *rentalTotalView;
@property (nonatomic, strong) CTLabel *rentalTotalLabel;
@property (nonatomic, strong) UIImageView *chevronImageView;
@property (nonatomic, strong) UIView *chevronBackground;

@property (nonatomic, strong) CTLayoutManager *layoutManager;
@end

@implementation CTPaymentSummaryExpandedView

// MARK: View Creation

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.chevronBackground = [self createChevronBackground];
        [self addSubview:self.chevronBackground];
        
        self.containerView = [self createContainerView];
        [self addSubview:self.containerView];
        
        self.tableView = [self createTableView];
        [self.containerView addSubview:self.tableView];
        
        self.divider = [self createDivider];
        [self.containerView addSubview:self.divider];
        
        self.rentalTotalView = [self createRentalTotalView];
        [self.containerView addSubview:self.rentalTotalView];
        
        self.chevronImageView = [self createChevronImageView];
        [self addSubview:self.chevronImageView];
        
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
    tableView.rowHeight = 30;
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

- (UIView *)createChevronBackground {
    UIView *chevron = [UIView new];
    chevron.translatesAutoresizingMaskIntoConstraints = NO;
    chevron.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
    return chevron;
}

- (UIImageView *)createChevronImageView {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UIImage *chevronImage = [[UIImage imageNamed:@"down_arrow" inBundle:bundle compatibleWithTraitCollection:nil] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *chevronImageView = [[UIImageView alloc] initWithImage:chevronImage];
    chevronImageView.tintColor = [UIColor whiteColor];
    chevronImageView.translatesAutoresizingMaskIntoConstraints = NO;
    chevronImageView.transform = CGAffineTransformMakeScale(1, -1);
    return chevronImageView;
}

- (void)applyConstraints {
    NSDictionary *views = @{@"containerView": self.containerView, @"tableView": self.tableView, @"divider": self.divider, @"rentalTotalView": self.rentalTotalView, @"chevron": self.chevronBackground};
    
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
                                                        toItem:self.chevronBackground
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.chevronBackground
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1.0
                                                      constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevronBackground
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:nil
                                                     attribute:NSLayoutAttributeNotAnAttribute
                                                    multiplier:1.0
                                                      constant:40.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevronBackground
                                                     attribute:NSLayoutAttributeWidth
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.chevronBackground
                                                     attribute:NSLayoutAttributeHeight
                                                    multiplier:1.0
                                                      constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevronImageView
                                                        attribute:NSLayoutAttributeWidth
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.chevronBackground
                                                        attribute:NSLayoutAttributeWidth
                                                       multiplier:0.3
                                                         constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevronImageView
                                                        attribute:NSLayoutAttributeHeight
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.chevronBackground
                                                        attribute:NSLayoutAttributeHeight
                                                       multiplier:0.3
                                                         constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevronImageView
                                                        attribute:NSLayoutAttributeCenterX
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.chevronBackground
                                                        attribute:NSLayoutAttributeCenterX
                                                       multiplier:1.0
                                                         constant:0.0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.chevronImageView
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.chevronBackground
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:5.0]];
}

// MARK: View Update

- (void)updateWithSearch:(CTRentalSearch *)search {
    self.search = search;
    
    self.rentalTotalLabel.text = [self.vehicle.totalPriceForThisVehicle numberStringWithCurrencyCode];
    
    [self.tableView reloadData];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewHeightConstraint.constant = self.tableView.contentSize.height;
}

- (CTVehicle *)vehicle {
    return self.search.selectedVehicle.vehicle;
}

- (CGFloat)desiredHeight {
    return self.tableView.contentSize.height + self.divider.intrinsicContentSize.height + 40 + self.rentalTotalLabel.intrinsicContentSize.height + 15;
}

// MARK: Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (section == 0) ? [self payNowCharges].count : [self payAtDeskCharges].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CTPaymentSummaryExpandedTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:3.0/255.0 green:40.0/255.0 blue:101.0/255.0 alpha:1.0];
    [cell updateWithModel:[self chargeAtIndexPath:indexPath]];
    return cell;
}

- (id)chargeAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *charges = indexPath.section == 0 ? [self payNowCharges] : [self payAtDeskCharges];
    return charges[indexPath.row];
}

- (NSArray *)payNowCharges {
    NSMutableArray *charges = [NSMutableArray new];
    
    for (CTFee *fee in self.vehicle.fees) {
        if ((fee.feePurpose == CTFeeTypePayNow || fee.feePurpose == CTFeeTypeBooking) && fee.feeAmount.integerValue > 0) {
            [charges addObject:fee];
        }
    }

    if (self.search.isBuyingInsurance) {
        [charges addObject:self.search.insurance];
    }
    
    return charges.copy;
}

- (NSArray *)payAtDeskCharges {
    NSMutableArray *charges = [NSMutableArray new];
    
    for (CTFee *fee in self.vehicle.fees) {
        if (fee.feePurpose == CTFeeTypePayAtDesk && fee.feeAmount.integerValue > 0) {
            [charges addObject:fee];
        }
    }
    
    for (CTExtraEquipment *extra in self.vehicle.extraEquipment) {
        if (extra.isIncludedInRate || extra.qty > 0) {
            [charges addObject:extra];
        }
    }
    
    if (charges.count == 0) {
        [charges addObject:CTLocalizedString(CTRentalPayNothingAtDesk)];
    }
    
    return charges.copy;
}

// MARK: UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0;
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
    [CTLayoutManager pinView:headerLabel toSuperView:view];
    
    return view;
}

// MARK: Image Rounding

- (void)layoutSubviews {
    [super layoutSubviews];
    [self layoutIfNeeded];
    self.chevronBackground.layer.cornerRadius = self.chevronBackground.frame.size.width / 2;
}

@end
