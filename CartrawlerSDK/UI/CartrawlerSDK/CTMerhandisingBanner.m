//
//  CTMerhandisingBanner.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 02/11/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTMerhandisingBanner.h"
#import "CTLabel.h"
#import "CTAppearance.h"

@interface CTMerhandisingBanner()

@property (nonatomic, strong) CTLabel *textLabel;

@end

@implementation CTMerhandisingBanner

+ (void)forceLinkerLoad_ {}

- (void)awakeFromNib
{
    [super awakeFromNib];
    _textLabel = [CTLabel new];
    self.textLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.textLabel.useBoldFont = YES;
    self.textLabel.font = [UIFont fontWithName:[CTAppearance instance].boldFontName size:12];

    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.textLabel];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-4-[text]-4-|" options:0
                                                                 metrics:nil
                                                                   views:@{ @"text" : self.textLabel }]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-4-[text]-8-|" options:0
                                                                 metrics:nil
                                                                   views:@{ @"text" : self.textLabel }]];
    
}

- (void)setBannerType:(CTMerhandisingBannerType)bannerType
{
    switch (bannerType) {
        case CTMerhandisingBannerTypeBestSeller:
            self.textLabel.text = @"BEST SELLER";
            self.backgroundColor = [CTAppearance instance].merchandisingBestSeller;
            self.textLabel.textColor = [UIColor whiteColor];
            self.hidden = NO;
            break;
            
        case CTMerhandisingBannerTypeGreatValue:
            self.textLabel.text = @"GREAT VALUE";
            self.backgroundColor = [CTAppearance instance].merchandisingGreatValue;
            self.textLabel.textColor = [UIColor whiteColor];
            self.hidden = NO;
            break;
            
        case CTMerhandisingBannerTypeNone:
            self.hidden = YES;
            break;
            
        default:
            break;
    }
    
    for (NSLayoutConstraint *c in self.constraints) {
        if (c.firstAttribute == NSLayoutAttributeWidth) {
            c.constant = self.textLabel.intrinsicContentSize.width + 12;
        }
    }
}

@end
