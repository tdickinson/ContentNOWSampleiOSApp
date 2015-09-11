//
//  OWSItemDefinition.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItemDefinition.h"
#import "OWSItemValue.h"

@implementation OWSItemDefinition

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"name", @"type"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"values"
                                                                        toKeyPath:@"values"
                                                                      withMapping:[OWSItemValue mappingForClass]]];
    return map;
}

@end
