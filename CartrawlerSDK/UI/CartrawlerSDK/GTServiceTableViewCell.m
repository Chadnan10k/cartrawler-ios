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
#import "InclusionCollectionViewCell.h"

@interface GTServiceTableViewCell() 

@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet CTLabel *serviceLevelLabel;
@property (weak, nonatomic) IBOutlet CTLabel *baggageLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *greetingLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;
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
    
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.inclusionsCollectionView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
//    if (service.inclusions.count > 0) {
//        self.inclusionsCollectionView.hidden = NO;
//        
//        [self.inclusionDataSource setInclusions:service.inclusions];
//        
//        self.inclusionsCollectionView.dataSource = self.inclusionDataSource;
//        self.inclusionsCollectionView.delegate = self.inclusionDataSource;
//        [self.inclusionsCollectionView reloadData];
//        [self.inclusionsCollectionView layoutIfNeeded];
//        
//        heightConstraint.constant = self.inclusionsCollectionView.collectionViewLayout.collectionViewContentSize.height;
//        [self.inclusionsCollectionView layoutIfNeeded];
//        [self layoutIfNeeded];
//    } else {
        heightConstraint = 0;
        self.inclusionsCollectionView.hidden = YES;
    //}
    
}

- (void)setShuttle:(CTGroundShuttle *)shuttle
{
    
    [[CTImageCache sharedInstance] cachedImage: shuttle.vehicleImage completion:^(UIImage *image) {
        self.vehicleImageView.image = image;
    }];
    
    self.baggageLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxBaggage];
    self.passengersLabel.text = [NSString stringWithFormat:@"%@", shuttle.maxPassengers];

    self.priceLabel.text = [NSNumberUtils numberStringWithCurrencyCode:shuttle.totalCharge];
        
    NSLayoutConstraint *heightConstraint;
    for (NSLayoutConstraint *constraint in self.inclusionsCollectionView.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeHeight) {
            heightConstraint = constraint;
            break;
        }
    }
    
    if (shuttle.inclusions.count > 0) {
        
        self.inclusionsCollectionView.hidden = NO;
        
        //[self.inclusionDataSource setInclusions:shuttle.inclusions];
        
        self.inclusionsCollectionView.dataSource = self.inclusionDataSource;
        self.inclusionsCollectionView.delegate = self.inclusionDataSource;
        [self.inclusionsCollectionView reloadData];
        
        heightConstraint.constant = 200;
        [self.inclusionsCollectionView layoutIfNeeded];
        [self layoutIfNeeded];
        
    } else {
        heightConstraint = 0;
        self.inclusionsCollectionView.hidden = YES;
    }

}

- (void)awakeFromNib {
    [super awakeFromNib];
}


@end
