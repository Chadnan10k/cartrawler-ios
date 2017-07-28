//
//  CTSearchSettingsSelectionViewModel.m
//  CartrawlerSDK
//
//  Created by Alan Pearson Mathews on 7/25/17.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import "CTSearchSettingsSelectionViewModel.h"
#import "CTAppState.h"

@interface CTSearchSettingsSelectionViewModel ()
@property (nonatomic, readwrite) UIColor *navigationBarColor;
@property (nonatomic, readwrite) NSString *title;
@property (nonatomic, readwrite) NSString *closeButtonTitle;
@property (nonatomic, readwrite) NSArray *rowViewModels;
@end

@implementation CTSearchSettingsSelectionViewModel

+ (instancetype)viewModelForState:(CTAppState *)appState {
    CTSearchSettingsSelectionViewModel *viewModel = [CTSearchSettingsSelectionViewModel new];
    CTSearchState *searchState = appState.searchState;
    
    viewModel.navigationBarColor = appState.userSettingsState.primaryColor;
    
    NSString *fileName;
    
    switch (searchState.selectedSettings) {
        case CTSearchSearchSettingsCountry:
            fileName = @"CTISOCountries";
            viewModel.title = @"Select Country";// CTLocalizedString(CTRentalSettingsSelectCountry);
            break;
        case CTSearchSearchSettingsLanguage:
            fileName = @"CTLanguages";
            viewModel.title = @"Select Language";//CTLocalizedString(CTRentalSettingsSelectLanguage);
            break;
        case CTSearchSearchSettingsCurrency:
            fileName = @"CTCurrency";
            viewModel.title = @"Select Currency";//CTLocalizedString(CTRentalSettingsSelectCurrency);
            break;
        default:
            break;
    }
    
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    NSString *path = [b pathForResource:fileName
                                 ofType:@"csv"];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSMutableArray *rowViewModels = [[NSMutableArray alloc] init];
    NSArray *rows = [content componentsSeparatedByString:@"\n"];
    for (NSString *row in rows){
        NSArray *columns = [row componentsSeparatedByString:@","];
        if (columns.count >=2) {
            CTCSVItem *item = [[CTCSVItem alloc] initWithName:columns[0] code:columns[1]];
            
            switch (searchState.selectedSettings) {
                case CTSearchSearchSettingsCountry:
                    item.displayName = [NSString stringWithFormat:@"%@ (%@)", item.name, item.code];
                    break;
                case CTSearchSearchSettingsLanguage:
                    item.displayName = [NSString stringWithFormat:@"%@", item.code];
                    break;
                case CTSearchSearchSettingsCurrency:
                    item.displayName = [NSString stringWithFormat:@"%@", item.name];
                    break;
                default:
                    break;
            }
            [rowViewModels addObject:item];
        }
    }
    
    viewModel.rowViewModels = rowViewModels.copy;
    
    return viewModel;
}

@end
