//
//  OWSItemIdInformation.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSItemIdInformation.h"

@implementation OWSItemIdInformation

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"isPrimary", @"itemId"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"itemIdType"
                                                                        toKeyPath:@"itemIdType"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
