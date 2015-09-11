//
//  ViewController.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/25/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSItem.h"

typedef NS_ENUM(NSUInteger, OWSTargetView) {
    OWSTargetViewScan,
    OWSTargetViewSearch,
    OWSTargetViewSettings,
    OWSTargetViewDetails,
};
/**
 * Primary "container" view controller that hosts the rest
 */
@interface ViewController : UIViewController

/**
 * Which child view controller to go to
 */
@property (nonatomic) OWSTargetView target;

/**
 * Extra parameter for the child view controller (e.g. the search keyword, or the array of results). Only needed if setting this during the segue where this view controller loads.
 */
@property (nonatomic, strong) NSObject *targetViewControllerParam;

/**
 * Show search screen and execute a search for the given string
 */
- (void)showSearch:(NSString *)searchString;

/**
 * Show settings screen
 */
- (void)showSettings;

@end
