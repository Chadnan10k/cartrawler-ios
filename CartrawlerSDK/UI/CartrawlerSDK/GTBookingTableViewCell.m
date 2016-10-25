//
//  GTBookingTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 13/10/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "GTBookingTableViewCell.h"
#import "CTLabel.h"
#import "CTImageCache.h"
#import "DateUtils.h"

@interface GTBookingTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bookingImageView;
@property (weak, nonatomic) IBOutlet CTLabel *locationLabel;
@property (weak, nonatomic) IBOutlet CTLabel *dateLabel;
@property (weak, nonatomic) IBOutlet CTLabel *refLabel;

@end

@implementation GTBookingTableViewCell

+ (void)forceLinkerLoad_ { }

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(GTBooking *)booking
{
    if (booking.vehicleImage) {
        [[CTImageCache sharedInstance] cachedImage:[[NSURL alloc] initWithString:booking.vehicleImage] completion:^(UIImage *image) {
            self.bookingImageView.image = image;
        }];
    } else {
        //sample car image?
    }
    
    self.locationLabel.text = booking.pickupLocation;
    self.dateLabel.text = [DateUtils stringFromDate:booking.pickupDate withFormat:@"dd/mm/yyyy hh:mm a"];
    self.refLabel.text = booking.bookingId;
}

@end
