//
//  InclusionsTableViewCell.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 12/09/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "InclusionsTableViewCell.h"
#import "CTLabel.h"

@interface InclusionsTableViewCell()

@property (weak, nonatomic) IBOutlet CTLabel *typeLabel;

@end

@implementation InclusionsTableViewCell

+ (void)forceLinkerLoad_
{
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setText:(Inclusion )inclusion
{
    self.typeLabel.text = [self inclusionText:inclusion];
}

- (NSString *)inclusionText:(Inclusion)inclusion
{
    
    switch (inclusion) {
        case InclusionAirCon: {
            return NSLocalizedString(@"Air Con", @"Air Con");
            
        }
        case InclusionBathroom: {
            return NSLocalizedString(@"Bathroom", @"Bathroom");
            
        }
        case InclusionBike: {
            return NSLocalizedString(@"Bike", @"Bike");
            
        }
        case InclusionChildSeats: {
            return NSLocalizedString(@"Child Seats", @"");
            
        }
        case InclusionDriverLanguages: {
            return NSLocalizedString(@"Driver Languages", @"");
            
        }
        case InclusionExtraPrivacyLegroom: {
            return NSLocalizedString(@"Extra Privacy & Legroom", @"");
            
        }
        case InclusionMagazines: {
            return NSLocalizedString(@"Magazines", @"");
            
        }
        case InclusionMakeModel: {
            return NSLocalizedString(@"Make model", @""); // ??
            
        }
        case InclusionNewspaper: {
            return NSLocalizedString(@"Newspaper", @"");
            
        }
        case InclusionOversizeLuggage: {
            return NSLocalizedString(@"Oversize Luggage", @"");
            
        }
        case InclusionPhoneCharger: {
            return NSLocalizedString(@"Phone Charger", @"");
            
        }
        case InclusionPowerSocket: {
            return NSLocalizedString(@"Power Socket", @"");
            
        }
        case InclusionSMS: {
            return NSLocalizedString(@"SMS", @"");
            
        }
        case InclusionSnacks: {
            return NSLocalizedString(@"Snacks", @"");
            
        }
        case InclusionTablet: {
            return NSLocalizedString(@"Tablet", @"");
            
        }
        case InclusionWaitMinutes: {
            return NSLocalizedString(@"Wait Minutes", @""); //??
            
        }
        case InclusionWheelchairAccess: {
            return NSLocalizedString(@"Wheelchair Access", @"");
            
        }
        case InclusionWifi: {
            return NSLocalizedString(@"Wifi", @"");
            
        }
        case InclusionWorkTable: {
            return NSLocalizedString(@"Work Table", @"");
            
        }
        case InclusionVideo: {
            return NSLocalizedString(@"Video", @"");
            
        }
        case InclusionWater: {
            return NSLocalizedString(@"Water", @"");
            
        }
    }
    
    return @"";
}

@end
