//
//  OWSNetContent.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSNetContent.h"
#import "OWSQualValue.h"
@implementation OWSNetContent

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"qualDefinition"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"values"
                                                                        toKeyPath:@"values"
                                                                      withMapping:[OWSQualValue mappingForClass]]];
    return map;
}

@end
