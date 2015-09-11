//
//  SearchResultTableViewCell.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSSearchResult.h"

@interface SearchResultTableViewCell : UITableViewCell

/**
 * Set up the cell to show details of the given item
 */
- (void)setUpWithResultItem:(OWSSearchResult *)result;

@end
