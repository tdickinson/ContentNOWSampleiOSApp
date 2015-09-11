//
//  LocationManager.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "LocationManager.h"
#import "SettingsManager.h"
#import <CoreLocation/CoreLocation.h>

@interface LocationManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation LocationManager

+ (LocationManager *)sharedInstance {
    static LocationManager *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LocationManager alloc] init];
    });
    return sharedInstance;
}

- (void)startSignificantChangeUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
    }
    

    [self.locationManager startMonitoringSignificantLocationChanges];
}

- (void)stopSignificantChangeUpdates {
    [self.locationManager stopMonitoringSignificantLocationChanges];
}

#pragma mark - CLLocationManagerDelegate

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {

    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is old, ignore it. If it's recent, update our last known location
        [SettingsManager setLatestLocation:location];
    }
}

@end
