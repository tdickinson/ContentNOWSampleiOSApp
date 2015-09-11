//
//  OWSCodeMapping.h
//  1WorldSync
//
//  Created by OpenPath Products on 8/29/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWSItem.h"

@interface OWSCodeMapping : NSObject

/**
 * Returns the display string to use for the given code string (from the server), in the given item
 */
+ (NSString *)displayStringForCode:(NSString *)codeString forDefinitionName:(NSString *)definitionName inItem:(OWSItem *)item;

@end
