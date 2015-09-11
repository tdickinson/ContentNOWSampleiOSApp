//
//  OWSItemDefinitions.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItemDefinitions.h"
#import "OWSItemDefinition.h"

@implementation OWSItemDefinitions

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];

    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"definitions"
                                                                        toKeyPath:@"definitions"
                                                                      withMapping:[OWSItemDefinition mappingForClass]]];
    return map;
}

@end
