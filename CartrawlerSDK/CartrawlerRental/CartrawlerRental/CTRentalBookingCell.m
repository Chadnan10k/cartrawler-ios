//
//  CTRentalBookingCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTRentalBookingCell.h"
#import <CartrawlerSDK/CTLabel.h>
#import <CartrawlerSDK/CartrawlerSDK+NSDateUtils.h>
#import <CartrawlerSDK/CTAppearance.h>

@interface CTRentalBookingCell()

@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *pickupTimeLabel;
@property (weak, nonatomic) IBOutlet CTLabel *pickupDateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropoffTimeLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dropoffDateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *vehicleNameLabel;
@property (weak, nonatomic) IBOutlet CTLabel *refLabel;
@property (weak, nonatomic) IBOutlet UIView *locationContainerView;

@end

@implementation CTRentalBookingCell




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.locationContainerView.backgroundColor = [CTAppearance instance].iconTint;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CTRentalBooking *)booking
{
    self.locationLabel.text = booking.pickupLocation;
    self.pickupTimeLabel.text = [booking.pickupDate stringFromDateWithFormat:@"hh:mm a"];
    self.dropoffTimeLabel.text = [booking.dropoffDate stringFromDateWithFormat:@"hh:mm a"];
    self.pickupDateLabel.text = [booking.pickupDate stringFromDateWithFormat:@"dd MMM YYYY"];
    self.dropoffDateLabel.text = [booking.dropoffDate stringFromDateWithFormat:@"dd MMM YYYY"];
    self.refLabel.text = [NSString stringWithFormat:@"%@: %@", booking.supplier, booking.bookingId];
    self.vehicleNameLabel.text = booking.vehicleName;
    
    NSAttributedString *vehicleName = [[NSAttributedString alloc] initWithString:booking.vehicleName ?: @""
                                                                      attributes:@{
                                                                                   NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].boldFontName size:17],
                                                                                   NSForegroundColorAttributeName : [CTAppearance instance].navigationBarColor
                                                                                   }];
    NSAttributedString *orSimilar = [[NSAttributedString alloc] initWithString:@" or similar"
                                                                      attributes:@{
                                                                                   NSFontAttributeName : [UIFont fontWithName:[CTAppearance instance].fontName size:17],
                                                                                   NSForegroundColorAttributeName : [CTAppearance instance].navigationBarColor
                                                                                   }];
    NSMutableAttributedString *compoundVehicleName = [[NSMutableAttributedString alloc] init];
    [compoundVehicleName appendAttributedString:vehicleName];
    [compoundVehicleName appendAttributedString:orSimilar];

    self.vehicleNameLabel.attributedText = compoundVehicleName;
}

@end
