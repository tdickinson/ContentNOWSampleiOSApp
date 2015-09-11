//
//  OWSValuesObject.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSValuesObject.h"
#import "OWSValue.h"

@implementation OWSValuesObject

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"values"
                                                                        toKeyPath:@"values"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
