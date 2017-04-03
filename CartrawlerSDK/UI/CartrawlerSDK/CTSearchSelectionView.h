//
//  CTSearchSelectionView.h
//  CartrawlerRental
//
//  Created by Lee Maguire on 29/03/2017.
//  Copyright © 2017 Cartrawler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CTSearchSelectionView;

@protocol CTSearchSelectionViewDelegate <NSObject>

- (void)didTapSelectionView:(CTSearchSelectionView *)selectionView;

@end

@interface CTSearchSelectionView : UIView

@property (nonatomic, strong) id<CTSearchSelectionViewDelegate> delegate;


/**
 State is you want to use the view as a button or a UITextField
 */
@property (nonatomic) BOOL useAsButton;

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

@end


