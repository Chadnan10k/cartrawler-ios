//
//  SelectCountryViewController.m
//  CartrawlerSDK
//
//  Created by Lee Maguire on 18/07/2016.
//  Copyright © 2016 Cartrawler. All rights reserved.
//

#import "CTSettingsSelectionViewController.h"
#import <CartrawlerSDK/CTAppearance.h>
#import <CartrawlerSDK/CTLabel.h>

@interface CTSettingsSelectionViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray<CTCSVItem *> *data;
@property (weak, nonatomic) IBOutlet CTLabel *titleLabel;

@property (nonatomic) SettingsType settingType;

@end

@implementation CTSettingsSelectionViewController




- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _data = [[NSMutableArray alloc] init];
    
    NSString *fileName;
    
    switch (self.settingType) {
        case SettingsTypeCountry:
            fileName = @"CTISOCountries";
            self.titleLabel.text = NSLocalizedString(@"Select Country", @"Select Country");
            break;
        case SettingsTypeCurrency:
            fileName = @"CTCurrency";
            self.titleLabel.text = NSLocalizedString(@"Select Currency", @"Select Currency");
            break;
        case SettingsTypeLanguage:
            fileName = @"CTLanguages";
            self.titleLabel.text = NSLocalizedString(@"Select Language", @"Select Language");
            break;
        default:
            break;
    }
    
    NSBundle *b = [NSBundle bundleForClass:[self class]];
    
    NSString* path = [b pathForResource:fileName
                                        ofType:@"csv"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    

    NSArray* rows = [content componentsSeparatedByString:@"\n"];
    for (NSString *row in rows){
        NSArray* columns = [row componentsSeparatedByString:@","];
        if (columns.count >=2) {
            [self.data addObject:[[CTCSVItem alloc] initWithName:columns[0] code:columns[1]]];
        }
    }
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.settingsCompletion) {
        self.settingsCompletion(self.data[indexPath.row]);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    switch (self.settingType) {
        case SettingsTypeCountry:
            cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", self.data[indexPath.row].name, self.data[indexPath.row].code];
            break;
        case SettingsTypeCurrency:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", self.data[indexPath.row].name];

            break;
        case SettingsTypeLanguage:
            cell.textLabel.text = [NSString stringWithFormat:@"%@", self.data[indexPath.row].code];
            break;
        default:
            break;
    }
    
    cell.textLabel.font =  [UIFont fontWithName:[CTAppearance instance].fontName size:16];
    return cell;
}

- (void)setSettingsType:(SettingsType)settingsType;
{
    _settingType = settingsType;
}

@end
