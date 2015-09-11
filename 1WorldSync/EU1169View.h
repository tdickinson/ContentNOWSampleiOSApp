//
//  EU1169View.h
//  1WorldSync
//
//  Created by OpenPath Products on 11/7/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSItem.h"

/**
 * Dynamically shows all EU1169 product data for a given OWSItem
 */
@interface EU1169View : UIView

/**
 * Shows the EU1169 info for the given item
 */
- (void)showItem:(OWSItem *)item;

@end
