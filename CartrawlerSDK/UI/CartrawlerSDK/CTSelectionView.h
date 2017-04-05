//
//  CTSearchSelectionView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTSelectionView;

@protocol CTSelectionViewDelegate <NSObject>

- (void)selectionViewWasTapped:(CTSelectionView *)selectionView;

- (void)selectionViewShouldBeginEditing:(CTSelectionView *)selectionView;

@end

@interface CTSelectionView : UIView

@property (nonatomic, strong) id<CTSelectionViewDelegate> delegate;


/**
 Getter for detail text field text
 */
@property (nonatomic, strong, readonly) NSString *textFieldText;

/**
 State is you want to use the view as a button or a UITextField
 */
@property (nonatomic) BOOL useAsButton;

/**
 Optional, use if you want to pass a RegEx
 */
@property (nonatomic, strong) NSString *regex;

/**
 Specify the keyboard type
 */
@property (nonatomic) UIKeyboardType keyboardType;

/**
 Designated initialiser

 @param placeholderText The placeholder text

 @return CTSearchSelectionView
 */
- (instancetype)initWithPlaceholder:(NSString *)placeholderText;


/**
 Used to set the placeholder text

 @param placeholderText The placeholder text
 */
- (void)setPlaceholder:(NSString *)placeholderText;


/**
 Used to set the detail text

 @param detailText The detail text
 */
- (void)setDetailText:(NSString *)detailText;


/**
 Shake animaion
 */
- (void)animate;

@end


