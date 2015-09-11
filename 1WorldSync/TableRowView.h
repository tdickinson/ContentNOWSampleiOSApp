//
//  TableRowView.h
//  1WorldSync
//
//  Created by OpenPath Products on 11/21/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSIngredient.h"

/**
 * Shows a row in a table. Equally sizes each label created from the strings array.
 */
@interface TableRowView : UIView

/**
 * Puts each of the given strings in an equally-sized column. If bold then larger font will be used
 */
- (void)setupWithStrings:(NSArray *)strings bold:(BOOL)bold;

@end
