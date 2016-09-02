//
//  GTServiceTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 14/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTServiceTableViewCell.h"
#import "CTLabel.h"
#import "CTImageCache.h"
#import "NSNumberUtils.h"
#import "InclusionTableViewDataSource.h"
#import "InclusionTableViewCell.h"

@interface GTServiceTableViewCell() <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet CTLabel *serviceLevelLabel;
@property (weak, nonatomic) IBOutlet CTLabel *baggageLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *greetingLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITableView *inclusionsTableView;
@property (nonatomic, strong) NSArray <CTGroundInclusion *> *inclusions;

@end

@implementation GTServiceTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setService:(CTGroundService *)service
{
    [[CTImageCache sharedInstance] cachedImage: service.vehicleImage completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    self.carTypeLabel.text = service.vehicleType;
    //self.serviceLevelLabel.text = service.serviceLevel;
    self.baggageLabel.text = [NSString stringWithFormat:@"%@", service.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@", service.maxPassengers];
//    if (service.meetAndGreet) {
//        self.greetingLabel.text = @"Meet and greet";
//    } else {
//        self.greetingLabel.text = @"Curbside pickup: Call driver ";
//    }
    
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:service.totalCharge];
    
    
    NSAttributedString *pickupType = [[NSAttributedString alloc] initWithString:@"Curbside: "
                                                                 attributes:@{NSFontAttributeName:
                                                                                  [UIFont fontWithName:@"Avenir-HeavyOblique" size:14]}];
    
    NSAttributedString *pickupInfo = [[NSAttributedString alloc] initWithString:@"Call driver on courtesy telephone to arrange pick-up point"
                                                                attributes:@{NSFontAttributeName:
                                                                                 [UIFont fontWithName:@"Avenir-Oblique" size:14]}];
    
    
    NSMutableAttributedString *pickupStr = [[NSMutableAttributedString alloc] init];
    
    [pickupStr appendAttributedString:pickupType];
    [pickupStr appendAttributedString:pickupInfo];
    self.greetingLabel.attributedText = pickupStr;
    
    self.inclusionsTableView.dataSource = self;
    self.inclusionsTableView.delegate = self;
    [self.inclusionsTableView reloadData];
    
//    NSLayoutConstraint *heightConstraint;
//    for (NSLayoutConstraint *constraint in self.inclusionsTableView.constraints) {
//        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
//            heightConstraint = constraint;
//            break;
//        }
//    }
//    heightConstraint.constant = 1000;
//    [self.inclusionsTableView layoutIfNeeded];
    
}

- (void)setShuttle:(CTGroundService *)shuttle
{
    
    [[CTImageCache sharedInstance] cachedImage: shuttle.vehicleImage completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    self.baggageLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxPassengers];
    //    if (service.meetAndGreet) {
    //        self.greetingLabel.text = @"Meet and greet";
    //    } else {
    //        self.greetingLabel.text = @"Curbside pickup: Call driver ";
    //    }
    
    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:shuttle.totalCharge];
    
    
    NSAttributedString *pickupType = [[NSAttributedString alloc] initWithString:@"Curbside: "
                                                                     attributes:@{NSFontAttributeName:
                                                                                      [UIFont fontWithName:@"Avenir-HeavyOblique" size:16]}];
    
    NSAttributedString *pickupInfo = [[NSAttributedString alloc] initWithString:@"Call driver on courtesy telephone to arrange pick-up point"
                                                                     attributes:@{NSFontAttributeName:
                                                                                      [UIFont fontWithName:@"Avenir-Oblique" size:16]}];
    
    
    NSMutableAttributedString *pickupStr = [[NSMutableAttributedString alloc] init];
    
    [pickupStr appendAttributedString:pickupType];
    [pickupStr appendAttributedString:pickupInfo];
    self.greetingLabel.attributedText = pickupStr;
    
    self.inclusionsTableView.dataSource = self;
    self.inclusionsTableView.delegate = self;
    [self.inclusionsTableView reloadData];

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inclusions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InclusionTableViewCell *cell = (InclusionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell setText:@""];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

@end
