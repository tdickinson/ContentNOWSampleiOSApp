//
//  OWSSearchResult.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSSearchResult.h"
#import <RestKit/RestKit.h>

@implementation OWSSearchResult

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"item"
                                                                        toKeyPath:@"item"
                                                                      withMapping:[OWSItem mappingForClass]]];
    return map;
}

@end
