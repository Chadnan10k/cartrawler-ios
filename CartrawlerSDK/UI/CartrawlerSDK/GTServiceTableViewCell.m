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

@interface GTServiceTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *vehicleImageView;
@property (weak, nonatomic) IBOutlet CTLabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet CTLabel *serviceLevelLabel;
@property (weak, nonatomic) IBOutlet CTLabel *baggageLabel;
@property (weak, nonatomic) IBOutlet CTLabel *passengersLabel;
@property (weak, nonatomic) IBOutlet CTLabel *greetingLabel;
@property (weak, nonatomic) IBOutlet CTLabel *priceLabel;

@property (nonatomic, strong) CTGroundService *service;

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
    _service = service;
    
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
                                                                                  [UIFont fontWithName:@"Avenir-HeavyOblique" size:16]}];
    
    NSAttributedString *pickupInfo = [[NSAttributedString alloc] initWithString:@"Call driver on courtesy telephone to arrange pick-up point"
                                                                attributes:@{NSFontAttributeName:
                                                                                 [UIFont fontWithName:@"Avenir-Oblique" size:16]}];
    
    
    NSMutableAttributedString *pickupStr = [[NSMutableAttributedString alloc] init];
    
    [pickupStr appendAttributedString:pickupType];
    [pickupStr appendAttributedString:pickupInfo];
    self.greetingLabel.attributedText = pickupStr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
