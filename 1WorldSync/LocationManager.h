//
//  LocationManager.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocationManager : NSObject

+ (LocationManager *)sharedInstance;

/**
 * Start monitoring location
 */
- (void)startSignificantChangeUpdates;

/**
 * Stop monitoring location
 */
- (void)stopSignificantChangeUpdates;

@end
