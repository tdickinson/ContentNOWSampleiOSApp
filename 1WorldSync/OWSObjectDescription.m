//
//  OWSObjectDescription.m
//  1WorldSync
//
//  Created by OpenPath Products on 8/26/14.
//  Copyright (c) 2014 1WorldSync. All rights reserved.
//

#import "OWSObjectDescription.h"
#import "OWSValue.h"

@implementation OWSObjectDescription

+ (RKObjectMapping *)mappingForClass {
    RKObjectMapping* map = [RKObjectMapping mappingForClass:[self class]];
    [map addAttributeMappingsFromArray:@[@"languageDefinition"]];
    [map addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"values"
                                                                        toKeyPath:@"values"
                                                                      withMapping:[OWSValue mappingForClass]]];
    return map;
}

@end
