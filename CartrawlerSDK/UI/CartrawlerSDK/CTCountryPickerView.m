//
//  CTCountryPickerView.m
//  CartrawlerRental
//
//  Created by Lee Maguire on 19/04/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTCountryPickerView.h"
#import "CartrawlerSDK/CTLayoutManager.h"
#import "CartrawlerSDK/CTLocalisedStrings.h"
#import "CartrawlerSDK/CTSDKSettings.h"

@interface CTCountryPickerView() <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *countries;

@end

@implementation CTCountryPickerView

- (instancetype)init
{
    self = [super init];
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIPickerView *pickerView = [UIPickerView new];
    pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    pickerView.dataSource = self;
    pickerView.delegate = self;

    [self addSubview:pickerView];
    [CTLayoutManager pinView:pickerView toSuperView:self];
    
    _countries = @[@"IE", @"GB", @"ES", @"DE", @"US"];
    
    NSInteger index = [self.countries indexOfObject:[CTSDKSettings instance].homeCountryCode];
    
    [pickerView selectRow:index inComponent:0 animated:NO];
    
    return self;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.countries.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return CTLocalizedString(self.countries[row]);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.delegate) {
        [self.delegate didChangeCountrySelection:self.countries[row]];
    }
}

@end
