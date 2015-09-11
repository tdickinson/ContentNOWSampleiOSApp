//
//  OWSAdditive.m
//  1WorldSync
//
//  Created by OpenPath Products on 11/5/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSAdditive.h"

@implementation OWSAdditive

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"additiveName"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"additiveLevelOfContainment"
                                                                        toKeyPath:@"additiveLevelOfContainment"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
