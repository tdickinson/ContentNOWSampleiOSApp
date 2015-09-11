//
//  SettingsManager.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/27/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "OWSItem.h"

typedef NS_ENUM(NSUInteger, OWSLanguage) {
    OWSLanguageAll,
    OWSLanguageEnglish,
    OWSLanguageGerman,
};

@interface SettingsManager : NSObject

/**
 * Registers nsuserdefaults "defaults" for the settings
 */
+ (void)registerDefaults;

/**
 * API key for queries
 */
+ (NSString *)apiKey;

/**
 * App id for API queries
 */
+ (NSString *)appId;

/**
 * Base URL for API queries ( e.g. https://marketplace.preprod.api.1worldsync.com )
 */
+ (NSString *)baseUrl;

/**
 * Hardcoded product id to use regardless of what user scans. If nil or "" then real scan value will be used
 */
+ (NSString *)hardcodedProductId;

/**
 * Latest known latitude. Returns canned value if latest latitude is not known (for demo purposes)
 */
+ (NSNumber *)latestLatitude;

/**
 * Latest known longitude. Returns canned value if latest longitude is not known (for demo purposes)
 */
+ (NSNumber *)latestLongitude;

/**
 * Is in offline mode
 */
+ (BOOL)offlineMode;

/**
 * Show additional media or not
 */
+ (BOOL)showAdditionalMedia;

/**
 * Is in eu1169 mode. Otherwise, in ITI mode
 * @return YES if in eu1169 mode. NO if in ITI mode
 */
+ (BOOL)eu1169Mode;

/**
 * Currently selected language
 */
+ (OWSLanguage)language;

/**
 * Sets the API key. If nil the it removes the current one
 */
+ (void)setApiKey:(NSString *)apiKey;

/**
 * Sets the App Id. If nil the it removes the current one
 */
+ (void)setAppId:(NSString *)appId;

/**
 * Sets the Base url. If nil the it removes the current one
 */
+ (void)setBaseUrl:(NSString *)baseUrl;

/**
 * Sets the Hardcoded product id. If nil the it removes the current one
 */
+ (void)setHardcodedProductId:(NSString *)hardcodedProductId;

/**
 * Sets the latest known location
 */
+ (void)setLatestLocation:(CLLocation *)location;

/**
 * Set offline mode
 */
+ (void)setOfflineMode:(BOOL)offlineMode;

/**
 * Set whether additional media items should be shown
 */
+ (void)setShowAdditionalMedia:(BOOL)show;

/**
 * Set whether EU1169 mode should be on (if off, will use ITI view)
 */
+ (void)setEu1169Mode:(BOOL)eu1169ModeOn;

/**
 * Set language
 */
+ (void)setLanguage:(OWSLanguage)language;

/**
 * Loads the logo and tag images (if necessary) and calls completion block when finished
 */
+ (void)loadImagesIfNecessary:(void (^)(void))completion;

/**
 * Gets the image for the home screen logo
 */
+ (UIImage *)logoImage;

/**
 * Gets the image for the home screen "tag" image that's beneath the logo
 */
+ (UIImage *)tagImage;

/**
 * Gets the branding image for the details screen image (or nil if not set)
 */
+ (UIImage *)detailsBrandingImage;

/**
 * Gets the details branding color (defaults to light gray)
 */
+ (UIColor *)detailsBrandingColor;

/**
 * Gets the web app url for the given item
 */
+ (NSString *)urlStringForItem:(OWSItem *)item;

/**
 * Scales the given CGSize to @2x or @3x depending on device 
 */
+ (CGSize)updateSizeForDisplay:(CGSize)size;

@end
