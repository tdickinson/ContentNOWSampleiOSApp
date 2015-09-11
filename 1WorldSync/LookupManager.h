//
//  LookupManager.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

/**
 * Returns either the list of response objects or the error
 */
typedef void(^LookupResponseBlock)(NSArray *responseObjects, NSError *error);

@interface LookupManager : NSObject

+ (LookupManager *)sharedInstance;

/**
 * Do a free text search for the given term (puts a wildcard after the search term)
 * If the search is successful it will return the response as responseObjects, otherwise it will return an error
 */
- (void)search:(NSString*)searchTerm completion:(LookupResponseBlock)completion;

/**
 * Do a barcode lookup for the given barcode (as string)
 * If the search is successful it will return the response as responseObjects, otherwise it will return an error
 */
- (void)lookupCode:(NSString *)codeString completion:(LookupResponseBlock)completion;

/**
 * Get full details for the given item
 */
- (void)getDetails:(NSString*)itemId completion:(LookupResponseBlock)completion;

/**
 * Shows a standardized error based on the NSError parameter
 */
+ (void)showError:(NSError *)error;

/**
 * Do real proper URL encoding
 */
+ (NSString *)URLEncodeStringFromString:(NSString *)string;

/**
 * Retuns the most recent search string
 */
+ (NSString *)mostRecentSearchString;

/**
 * Sets the most recent search string
 */
+ (void)setMostRecentSearchString:(NSString *)string;

@end
