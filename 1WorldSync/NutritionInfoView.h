//
//  NutritionInfoView.h
//  1WorldSync
//
//  Created by OpenPath Products on 9/4/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "OWSItem.h"

/**
 * Custom class to show nutrition info. In order for its intrinsic size to work, it needs to have a fixed width given to its frame.
 */
@interface NutritionInfoView : UIView

/**
 * Shows the nutrition info for the given item
 */
- (void)showItem:(OWSItem *)item;

@end
