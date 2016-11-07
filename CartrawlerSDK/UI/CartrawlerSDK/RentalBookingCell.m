//
//  RentalBookingCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "RentalBookingCell.h"
#import "CTLabel.h"
#import "CartrawlerSDK+NSDateUtils.h"
#import "CTImageCache.h"

@interface RentalBookingCell()

@property (weak, nonatomic) IBOutlet UIImageView *bookingImageView;
@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *refLabel;

@end

@implementation RentalBookingCell




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(CTRentalBooking *)booking
{
    if (booking.vehicleImage) {
        [[CTImageCache sharedInstance] cachedImage:[[NSURL alloc] initWithString:booking.vehicleImage] completion:^(UIImage *image) {
            self.bookingImageView.image = image;
        }];
    } else {
        //sample car image?
    }
    /*
    NSString *locations = @"";
    
    if ([booking.pickupLocation isEqualToString:booking.dropoffLocation]) {
        locations = booking.pickupLocation;
    } else {
        locations = [NSString stringWithFormat:@"%@\nto\n%@", booking.pickupLocation, booking.dropoffLocation];
    }
    */
    self.locationLabel.text = booking.pickupLocation;
    
    NSString *dates = [NSString stringWithFormat:@"%@\nto\n%@", [booking.pickupDate stringFromDate:@"dd/MM/yyyy hh:mm a"], [booking.dropoffDate  stringFromDate:@"dd/MM/yyyy hh:mm a"]];
    
    self.dateLabel.text = dates;
    self.refLabel.text = booking.bookingId;
}

@end
